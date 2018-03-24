//
//  InputDisplayStylingService.swift
//  TypingGame
//
//  Created by adam tecle on 3/24/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

import RxSwift

protocol InputDisplayStylingServiceType {
    
    func createDisplayString(input: String, prompt: String) -> Observable<NSAttributedString>
}

final class InputDisplayStylingService: InputDisplayStylingServiceType {
    
    private static let promptText = """
    This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works.
    """
    
    private static let defaultAttributes = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28) ]
    
    static var defaultPrompt: NSAttributedString {
        let prompt = NSMutableAttributedString(string: promptText)
        prompt.addAttributes(defaultAttributes, range: promptText.range)
        prompt.addAttribute(.backgroundColor, value: UIColor.currentTextBackgroundColor, range: NSRange(location: 0, length: 1))
        return prompt
    }
    
    static func promptText(input: String, prompt: String) -> NSAttributedString {
        return NSAttributedString(string: promptText, attributes: defaultAttributes)
    }
    
    func createDisplayString(input: String, prompt: String) -> Observable<NSAttributedString> {
        let attributedText = NSMutableAttributedString(string: prompt)
        
//        let typedTextRange = typedRange(input: input, prompt: prompt)
//        let untypedTextRange = untypedRange(input: input, prompt: prompt)
//        let incorrectTextRange = incorrectRange(input: input, prompt: prompt)
        let currentTextRange = currentRange(input: input, prompt: prompt)
        attributedText.addAttribute(.backgroundColor, value: UIColor.currentTextBackgroundColor, range: currentTextRange)
        attributedText.addAttributes(InputDisplayStylingService.defaultAttributes, range: prompt.range)
        return Observable.just(attributedText)
    }
    
    private func typedRange(input: String, prompt: String) -> NSRange {
        return NSRange(location: 0, length: 0)
    }
    
    private func untypedRange(input: String, prompt: String) -> NSRange {
//        let inputCharacterCount = input.count
//        let promptCharacterCount = input.count
        
        return NSRange(location: 0, length: 0)
    }
    
    private func incorrectRange(input: String, prompt: String) -> NSRange {
        return NSRange(location: 0, length: 0)
    }
    
    private func currentRange(input: String, prompt: String) -> NSRange {
        return NSRange(location: input.count, length: 1)
    }

}
