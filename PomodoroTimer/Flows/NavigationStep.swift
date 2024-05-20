//
//  Step.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/18/24.
//

import Foundation
import RxFlow


enum NavigationStep: Step {
    // Splash
    case splash
    
    // TabBar
    case tabBarIsRequired
    
    // Home
    case homeIsRequired
    
    // History
    case historyIsRequired
}
