//
//  TypingViewReactor.swift
//  TypingGame
//
//  Created by adam tecle on 3/23/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

import RxSwift

final class TypingViewReactor: Reactor {
    
    let initialState: State
    var currentState: State

    enum Action {
        case updateText(String)
    }
    
    enum Mutation {
        case test
    }

    /// State must emit values to assign to attributed string.
    struct State {
        
    }
    
    init() {
        self.initialState = State()
        self.currentState = initialState
    }
    
    // Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        return Observable.just(Mutation.test)
    }

    // Mutation -> State
    func reduce(state: State, mutation: Mutation) -> TypingViewReactor.State {
        return initialState
    }
}
