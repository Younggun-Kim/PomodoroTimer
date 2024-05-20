//
//  HomeFlow.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import Foundation
import UIKit
import RxFlow
import RxFlow


class TabBarFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    let rootViewController = UITabBarController()
    
    init() {
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: any RxFlow.Step) -> RxFlow.FlowContributors {
        
        guard let step = step as? NavigationStep else {
            return .none
        }
        
        switch step {
        case .tabBarIsRequired:
            return self.navigationToTabBar()
        default:
            return .none
        }
    }
    
    func navigationToTabBar() -> FlowContributors {
        let homeFlow = HomeFlow()
        let historyFlow = HistoryFlow()
        
        Flows.use(homeFlow, historyFlow, when: .created) { [unowned self] (homeVC: UINavigationController, historyVC: UINavigationController) in
            homeVC.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "1.circle"), tag: 0)
            historyVC.tabBarItem = UITabBarItem(title: "HISTORY", image: UIImage(systemName: "2.circle"), tag: 1)
            
            self.rootViewController.setViewControllers([homeVC, historyVC], animated: false)
        }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow,
                        withNextStepper: OneStepper(withSingleStep: NavigationStep.homeIsRequired)),
            .contribute(withNextPresentable: historyFlow,
                        withNextStepper: OneStepper(withSingleStep: NavigationStep.historyIsRequired)),
        ])
    }
}
