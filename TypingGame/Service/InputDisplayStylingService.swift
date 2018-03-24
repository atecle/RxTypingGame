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
        return NSAttributedString(string: promptText, attributes: defaultAttributes)
    }
    
    static func promptText(input: String, prompt: String) -> NSAttributedString {
        return NSAttributedString(string: promptText, attributes: defaultAttributes)
    }
    
    func createDisplayString(input: String, prompt: String) -> Observable<NSAttributedString> {
        let typedTextRange = typedRange(input: input, prompt: prompt)
        let untypedTextRange = untypedRange(input: input, prompt: prompt)
        let incorrectTextRange = incorrectRange(input: input, prompt: prompt)
        let currentTextRange = currentRange(input: input, prompt: prompt)
        return Observable.just(NSAttributedString(string: InputDisplayStylingService.promptText,
                                                  attributes: InputDisplayStylingService.defaultAttributes))
    }
    
    private func typedRange(input: String, prompt: String) -> NSRange {
        return NSRange(location: 0, length: 0)
    }
    
    private func untypedRange(input: String, prompt: String) -> NSRange {
        return NSRange(location: 0, length: 0)
    }
    
    private func incorrectRange(input: String, prompt: String) -> NSRange {
        return NSRange(location: 0, length: 0)
    }
    
    private func currentRange(input: String, prompt: String) -> NSRange {
        return NSRange(location: 0, length: 0)
    }

}
