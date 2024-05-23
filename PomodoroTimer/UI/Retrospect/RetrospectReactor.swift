//
//  RetrospectReactor.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/23/24.
//

import Foundation
import ReactorKit
import RxSwift
import RxRelay
import RxFlow

// 회고 리액터
class RetrospectReactor: Reactor, Stepper {
    
    init() {
    }
    
    // MARK: - RxFlow Stepper
    
    var steps = PublishRelay<Step>()
    
    
    // MARK: - Reactor
    
    enum Action {
        case onTapClose
        
    }
    
    enum Mutation {
        case dismissPopup
        
    }
    
    struct State {
        
    }
    
    var initialState = State()
}


extension RetrospectReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .onTapClose:
            return .just(.dismissPopup)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .dismissPopup:
            self.steps.accept(NavigationStep.dismissRetrospect)
        }
        
        return state
    }
}
