//
//  Step.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/18/24.
//

import Foundation
import RxFlow
import RxRelay


enum NavigationStep: Step {
    // Splash
    case splash
    
    // TabBar
    case tabBarIsRequired
    
    // Home
    case homeIsRequired
    case moveSetting
    case settingSubmit(RecordModel)
    
    // History
    case historyIsRequired
}
