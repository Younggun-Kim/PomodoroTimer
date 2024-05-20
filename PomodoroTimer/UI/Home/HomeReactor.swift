//
//  HomeReactor.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import Foundation
import RxSwift
import RxFlow
import RxRelay
import ReactorKit

class HomeReactor: Reactor, Stepper {
    
    // MARK: Stepper
    
    let steps = PublishRelay<Step>()
    
    
    var initialStep: Step {
        return NavigationStep.homeIsRequired
    }
    
    
    // MARK: Reactor
    
    enum Action {
        
    }
    
    struct State {
        
    }
    
    var initialState = State()
}
