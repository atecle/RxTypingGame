//
//  ViewController.swift
//  TypingGame
//
//  Created by adam tecle on 3/23/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

final class TypingViewController: UIViewController, View {
    
    // MARK: - View
    
    var disposeBag = DisposeBag()

    // MARK: - IBOutlets
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Binding
    
    func bind(reactor: TypingViewReactor) {
        
    }

}

