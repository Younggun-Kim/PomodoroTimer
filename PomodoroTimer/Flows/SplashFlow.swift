//
//  SplashFlow.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/19/24.
//

import Foundation
import RxFlow


class SplashFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController: SplashViewController

    init() {
        rootViewController = SplashViewController()
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    
    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        return .none
    }
}
