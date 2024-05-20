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

class HistoryReactor: Reactor, Stepper {
    
    // MARK: Stepper
    
    let steps = PublishRelay<Step>()
    
    
    var initialStep: Step {
        return NavigationStep.historyIsRequired
    }
    
    
    // MARK: Reactor
    
    enum Action {
        
    }
    
    struct State {
        
    }
    
    var initialState = State()
}
