//
//  EditingBehaviorService.swift
//  TypingGame
//
//  Created by adam tecle on 3/25/18.
//  Copyright © 2018 adam tecle. All rights reserved.
//

import Foundation

import RxSwift

protocol EditingBehaviorServiceType {
    
    func shouldAllowEditing(input: String, prompt: String) -> Observable<Bool>
    
}

final class EditingBehaviorService: EditingBehaviorServiceType {
    
    func shouldAllowEditing(input: String, prompt: String) -> Observable<Bool> {
        return Observable.just(true)
    }
}
