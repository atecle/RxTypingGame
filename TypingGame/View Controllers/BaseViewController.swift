//
//  BaseViewController.swift
//  TypingGame
//
//  Created by adam tecle on 3/24/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    
    // MARK: Rx
    
    var disposeBag = DisposeBag()
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
}

