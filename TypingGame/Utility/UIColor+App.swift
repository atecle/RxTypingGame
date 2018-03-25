//
//  UIColor+App.swift
//  TypingGame
//
//  Created by adam tecle on 3/24/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let grayBackgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9411764706, blue: 0.9450980392, alpha: 1)
    
    static let untypedTextColor = UIColor.black
    
    static let typedTextColor = UIColor.gray
    
    static let incorrectTextBackgroundColor = UIColor.red.withAlphaComponent(0.5)
    
    static let currentTextBackgroundColor = UIColor.green.withAlphaComponent(0.5)
}
