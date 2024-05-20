//
//  splash.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/19/24.
//

import Foundation
import RxRelay
import RxFlow
import ReactorKit


class SplashReactor: Reactor, Stepper {
    
    let steps = PublishRelay<Step>()
    
    enum Action {
        case timeOut
    }
    
    enum Mutation {
        case moveNextPage
    }
    
    struct State {
        var canMoveNext: Bool = false
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .timeOut:
            return Observable<Mutation>.just(Mutation.moveNextPage)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .moveNextPage:
            self.steps.accept(NavigationStep.tabBarIsRequired)
        }
        
        return state
    }
}
