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
    
    // Login
    case loginIsRequired
    case userIsLoggedIn
}
