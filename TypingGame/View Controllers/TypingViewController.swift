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
        label.numberOfLines = 0
        label.backgroundColor = UIColor.white
        return label
    }
    
    // MARK: - Initialization
    
    init(reactor: TypingViewReactor) {
        super.init()
        setupView()
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
            .map { $0.isEditing }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak hiddenTextView] isEditing in
                _ = isEditing ? hiddenTextView?.becomeFirstResponder() : hiddenTextView?.resignFirstResponder()
            }).disposed(by: disposeBag)
    }
    
    // MARK: - View setup
    
    private func setupView() {
        view.addSubview(headerView)
        view.addSubview(hiddenTextView)
        view.addSubview(inputDisplayLabel)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(50)
        }
        hiddenTextView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.trailing.leading.bottom.equalToSuperview()
        }
        inputDisplayLabel.snp.makeConstraints {
            $0.top.equalTo(hiddenTextView)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}

