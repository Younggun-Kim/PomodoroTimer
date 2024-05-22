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
    
    
    // MARK: - RxFlow Stepper
    
    var steps = PublishRelay<Step>()
    
    
    // MARK: - Reactor
    
    enum Action {
        
    }
    
    struct State {
        var minutes = (1...12).map { $0 * 5 }
    }
    
    var initialState = State()
}
