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


class SplashFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        viewController.title = "SplashFlow"
        return viewController
    }()
    
    init() {}
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    
    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? NavigationStep else {
            return .none
        }
        
        switch step {
        case .tabBarIsRequired:
            return navigationToTabBar()
        default:
            return .none
        }
    }
    
    private func navigationToTabBar() -> FlowContributors {
        let tabBarFlow = TabBarFlow()        
        Flows.use(tabBarFlow, when: .created) { flowRoot in
            
//             SplashViewController에서 안 넘어가지는 버그.
//            self.rootViewController.pushViewController(flowRoot, animated: true)
            UIApplication.keyWindow?.rootViewController = flowRoot
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: tabBarFlow,
            withNextStepper: OneStepper(withSingleStep: NavigationStep.tabBarIsRequired))
        )
    }
}
