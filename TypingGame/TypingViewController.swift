//
//  ViewController.swift
//  TypingGame
//
//  Created by adam tecle on 3/23/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

/// first problem i want to solve is to have text color change as you type
final class TypingViewController: UIViewController {
    
    // MARK: - View
    
    var disposeBag = DisposeBag()
    typealias Action = TypingViewReactor.Action

    private var reactor: TypingViewReactor?

    // MARK: - IBOutlets
    
    @IBOutlet private weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    enum Color {
        static let defaultTextColor: UIColor = .darkGray
        static let correctTextColor: UIColor = .green
        static let incorrectTextColor: UIColor = .red
    }

    // MARK: - Binding
    
    func bind(reactor: TypingViewReactor) {
        textField.rx.text
            .asObservable()
            .map { Action.updateText($0 ?? "" ) }
            .bind(to: reactor.react)
            .subscribe { state in
                print(state)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Set up
    
    private func setup() {
        reactor = TypingViewReactor()
        bind(reactor: reactor!)
    }
    
}

