//
//  SettingReactor.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/22/24.
//

import Foundation
import ReactorKit
import RxSwift
import RxFlow
import RxRelay


class SettingReactor: Reactor, Stepper {
    
    
    init() { }
    
    // MARK: - RxFlow Stepper
    
    var steps = PublishRelay<Step>()
    
    
    // MARK: - Reactor
    
    enum Action {
        case submit
    }
    
    enum Mutation {
        case popVC
    }
    
    struct State {
        var minutes = (1...12).map { $0 * 5 }
    }
    
    var initialState = State()
}

extension SettingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .submit:
            return .just(.popVC)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .popVC:
            self.steps.accept(NavigationStep.settingSubmit)
        }
        
        return state
    }
}
