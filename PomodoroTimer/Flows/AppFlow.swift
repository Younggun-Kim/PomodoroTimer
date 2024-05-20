//
//  AppFlow.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/18/24.
//

import Foundation
import RxFlow
import RxRelay
import UIKit


class AppFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    private let services: AppServices
    
    
    init(services: AppServices) {
        self.services = services
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    
    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? NavigationStep else {
            return .none
        }
        
        switch step {
        case .splash:
            return navigationToSplash()
        default:
            return .none
        }
    }
}

extension AppFlow {
    
    private func navigationToSplash() -> FlowContributors {
        
        let splashVC = SplashViewController.instantiate("SplashViewController")
        let splashFlow = SplashFlow()
        
        self.rootViewController.setViewControllers([splashVC], animated: true)
        
        return .one(flowContributor: .contribute(
                withNextPresentable: splashVC,
                withNextStepper: OneStepper(withSingleStep: NavigationStep.splash)
            )
        )
    }
}


/**
 Stepper의 목적은 화면 이동 상태에 맞춰 Step을 방출하는 것.
 Stepper의 step에 accept() 하기만 하면 Coordinator에서 알맞는 Flow의 accept(to:)함수를 호출하게 된다.
 */
class AppStepper: Stepper {
    let steps = PublishRelay<Step>()

    var initialStep: Step {
        return NavigationStep.splash
    }
}
