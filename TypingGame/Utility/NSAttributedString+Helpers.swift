//
//  NSAttributedString+Helpers.swift
//  TypingGame
//
//  Created by adam tecle on 3/23/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

final class InputDisplayStylingService {
    
    private static let promptText = """
    This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works.
    """
    
    private static let defaultAttributes = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28) ]
    
    static var defaultPrompt: NSAttributedString {
        return NSAttributedString(string: promptText, attributes: defaultAttributes)
    }
    
    static func promptText(input: String, prompt: String) -> NSAttributedString {
        return  NSAttributedString(string: promptText, attributes: defaultAttributes)
    }
    
}
