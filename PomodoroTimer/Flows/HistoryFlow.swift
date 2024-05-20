//
//  HistoryFlow.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import Foundation
import UIKit
import RxFlow


class HistoryFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
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
        case .historyIsRequired:
            return self.navigationToHistory()
        default:
            return .none
        }
    }
    
    func navigationToHistory() -> FlowContributors {
        let reactor = HistoryReactor()
        let vc = HistoryViewController(reactor: reactor)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
}
