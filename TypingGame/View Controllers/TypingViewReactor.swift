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
        case setAllowEditing(Bool)
    }

    struct State {
        var showKeyboard: Bool
        var allowEditing: Bool
        var showStatusLabel: Bool
        var attributedText: NSAttributedString
    }
    
    init(provider: ServiceProviderType) {
        self.initialState = State(showKeyboard: false, allowEditing: true, showStatusLabel: false, attributedText: InputDisplayStylingService.defaultPrompt)
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
            let displayStringObservable = provider.stylingService
                .createDisplayString(input: text)
                .map { return Mutation.updateAttributedText($0) }
            let allowEditingObservable = provider.editingBehaviorService
                .shouldAllowEditing(input: text, prompt: InputDisplayStylingService.defaultPrompt.string)
                .map { Mutation.setAllowEditing($0) }
            return Observable.merge(displayStringObservable, allowEditingObservable)
        }
    }

    // Mutation -> State
    func reduce(state: State, mutation: Mutation) -> TypingViewReactor.State {
        var state = state
        switch mutation {
        case .updateAttributedText(let attributedText):
            state.attributedText = attributedText
            state.showKeyboard = true
        case .setAllowEditing(let allowEditing):
            state.allowEditing = allowEditing
        }

        return state
    }
    
}
