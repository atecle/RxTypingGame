//
//  ViewController.swift
//  TypingGame
//
//  Created by adam tecle on 3/23/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit

final class TypingViewController: BaseViewController, View {
    
    // MARK: - Properties

    private let headerView: UIView = TypingViewController.createHeaderView()
    private static func createHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }
    
    private let containerView: UIView = TypingViewController.createContainerView()
    private static func createContainerView() -> UIView {
        let view = UIView()
        return view
    }
    
    private let hiddenTextView: UITextView = TypingViewController.createHiddenTextView()
    private static func createHiddenTextView() -> UITextView {
        let textView = UITextView()
        textView.autocorrectionType = .no
        return textView
    }
    
    private let inputDisplayLabel: UILabel = TypingViewController.createInputDisplayLabel()
    private static func createInputDisplayLabel() -> UILabel {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }
    
    private let statusLabel: UILabel = TypingViewController.createStatusLabel()
    private static func createStatusLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.text = "Incorrect key entered"
        label.backgroundColor = .black
        label.isHidden = true
        label.numberOfLines = 1
        return label
    }
    
    // MARK: - Initialization
    
    init(reactor: TypingViewReactor) {
        super.init()
        setupView()
        title = "Type That Shit!"
        self.reactor = reactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Binding
    
    func bind(reactor: TypingViewReactor) {
        Observable.just(Void())
            .map { Reactor.Action.load }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        hiddenTextView.rx.text
            .map { Reactor.Action.updateText($0 ?? "" ) }
            .skip(1)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.asObservable()
            .map { $0.attributedText }
            .subscribe(onNext: { [weak inputDisplayLabel] in
                inputDisplayLabel?.attributedText = $0
        }).disposed(by: disposeBag)
        
        reactor.state.asObservable()
            .map { $0.showKeyboard }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak hiddenTextView] isEditing in
                _ = isEditing ? hiddenTextView?.becomeFirstResponder() : hiddenTextView?.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        reactor.state.asObservable()
            .map { $0.allowEditing }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak hiddenTextView] isEditing in
                _ = isEditing ? hiddenTextView?.becomeFirstResponder() : hiddenTextView?.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        hiddenTextView.rx.setDelegate(self).disposed(by: disposeBag)
        
        reactor.state.asObservable()
            .map { $0.showStatusLabel }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak statusLabel] show in
                statusLabel?.isHidden = !show
            }).disposed(by: disposeBag)
    }
    
    // MARK: - View setup
    
    private func setupView() {
        view.backgroundColor = .grayBackgroundColor
        containerView.backgroundColor = .white
        
        view.addSubview(headerView)
        view.addSubview(containerView)
        view.addSubview(statusLabel)
        
        containerView.addSubview(hiddenTextView)
        containerView.addSubview(inputDisplayLabel)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(50)
        }
        containerView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).inset(-20)
            $0.leading.equalTo(14)
            $0.trailing.equalTo(-14)
        }
        hiddenTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        inputDisplayLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        statusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(containerView.snp.bottom).inset(-20)
        }
        
    }
    
}

extension TypingViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var thisisBad = true
        reactor!.state.asObservable().map { $0.allowEditing }.bind(onNext: { allowEditing in
            thisisBad = allowEditing
        }).disposed(by: disposeBag)
        return thisisBad
    }
}

