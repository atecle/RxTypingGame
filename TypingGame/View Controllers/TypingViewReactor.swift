//
//  TypingViewReactor.swift
//  TypingGame
//
//  Created by adam tecle on 3/23/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

import ReactorKit
import RxSwift

final class TypingViewReactor: Reactor {
    
    let initialState: State
    var currentState: State
    
    private let provider: ServiceProviderType

    enum Action {
        case load
        case updateText(String)
    }
    
    enum Mutation {
        case updateAttributedText(NSAttributedString)
    }

    /// State must emit values to assign to attributed string.
    struct State {
        var attributedText: NSAttributedString
    }
    
    let promptText = """
    This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works. This is some default text that I'm adding to make sure that this app works.
    """
    
    let defaultAttributes = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 28) ]
    
    init(provider: ServiceProviderType) {
        self.initialState = State(attributedText: NSAttributedString(string: promptText, attributes: defaultAttributes))
        self.currentState = initialState
        self.provider = provider
    }
    
    // Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            let attributedText = InputDisplayStylingService.defaultPrompt
            return Observable.just(Mutation.updateAttributedText(attributedText))
        case .updateText(let text):
            let attributedText = InputDisplayStylingService.promptText(input: text, prompt: promptText)
            return Observable.just(Mutation.updateAttributedText(attributedText))
        }
    }

    // Mutation -> State
    func reduce(state: State, mutation: Mutation) -> TypingViewReactor.State {
        var state = state
        switch mutation {
        case .updateAttributedText(let attributedText):
            state.attributedText = attributedText
        }
        
        return state
    }
    
}
