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
        case onTapRating(Bool)
        case onTapSubmit
        case onInputDescription(String?)
    }
    
    enum Mutation {
        case dismissPopup
        case setRating(Bool)
        case setEnabledSubmit
        case setDescription(String?)
    }
    
    struct State {
        var rating: Bool? = nil
        
        var isEnabedSubmit = false
        
        var description: String?
    }
    
    var initialState = State()
}


extension RetrospectReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .onTapClose:
            return .just(.dismissPopup)
        case let .onTapRating(isGood):
            return Observable.concat([
                .just(.setRating(isGood)),
                .just(.setEnabledSubmit),
            ])
        case .onTapSubmit:
            // TODO: - 여기서 coreData저장이 되야함.
            return .just(.dismissPopup)
        case let .onInputDescription(description):
            return .just(.setDescription(description))
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .dismissPopup:
            self.steps.accept(NavigationStep.dismissRetrospect)
        case let .setRating(isGood):
            state.rating = isGood
        case .setEnabledSubmit:
            state.isEnabedSubmit = state.rating != nil
        case let .setDescription(description):
            state.description = description
        }
        
        return state
    }
}
