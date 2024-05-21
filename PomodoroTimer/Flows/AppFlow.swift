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
import ReactorKit


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
            
        case .tabBarIsRequired:
            return navigationToTabBar()
        default:
            return .none
        }
    }
}

extension AppFlow {
    private func navigationToSplash() -> FlowContributors {
        print(#fileID, #function, #line, "-")
//        let flow = SplashFlow()
//        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: NavigationStep.splash)))
        
        let reactor = SplashReactor()
        let vc = SplashViewController.instantiate(withReactor: reactor)
        let flow = SplashFlow()
        
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: reactor))
    }
    
    private func navigationToTabBar() -> FlowContributors {
        print(#fileID, #function, #line, "-")
        let tabBarFlow = TabBarFlow()
        
        Flows.use(tabBarFlow, when: .created) { flowRoot in
            self.rootViewController.pushViewController(flowRoot, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: tabBarFlow,
            withNextStepper: OneStepper(withSingleStep: NavigationStep.tabBarIsRequired))
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
