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
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    
    var initialState: State = State()
}
