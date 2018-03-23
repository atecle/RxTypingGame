//
//  Reactor.swift
//  TypingGame
//
//  Created by adam tecle on 3/23/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import RxSwift

protocol Reactor: class {
    associatedtype Action
    associatedtype Mutation
    associatedtype State
    
    var initialState: State { get }
    
    var currentState: State { get set }
    
    func react(actions: Observable<Action>) -> Observable<State>
    
    func mutate(action: Action) -> Observable<Mutation>
    
    func reduce(state: State, mutation: Mutation) -> State
    
}

extension Reactor {
    
    public func react(actions: Observable<Action>) -> Observable<State> {
        return actions
            .flatMap { [weak self] action -> Observable<Mutation> in
                guard let welf = self else { return .empty() }
                return welf.mutate(action: action)
            }
            .scan(self.currentState) { [weak self] state, mutation -> State in
                guard let welf = self else { return state }
                return welf.reduce(state: state, mutation: mutation)
            }
            .startWith(self.currentState)
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: { [weak self] state in
                guard let welf = self else { return }
                welf.currentState = state
            })
            .share(replay: 1)
    }
    
}
