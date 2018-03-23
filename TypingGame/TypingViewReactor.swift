//
//  TypingViewReactor.swift
//  TypingGame
//
//  Created by adam tecle on 3/23/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import UIKit

import RxSwift
import ReactorKit

final class TypingViewReactor: Reactor {
    
    let initialState: State
    
    struct State {
    }
    
    enum Action {
        
    }
    
    enum Mutation {
        case test
    }

    init() {
        self.initialState = State()
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
