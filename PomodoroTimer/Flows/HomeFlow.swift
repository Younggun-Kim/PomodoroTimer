//
//  HomeFlow.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import Foundation
import UIKit
import RxFlow
import RxSwift
import RxRelay


class HomeFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: BaseNavigationController = {
        let vc = BaseNavigationController()
        return vc
    }()
    
    // 설정 화면 데이터 응답 릴레이
    private var settingDataResponseRelay = PublishRelay<RecordModel>()
    
    init() {}
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    
    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? NavigationStep else {
            return .none
        }
        
        switch step {
        case .homeIsRequired:
            return self.navigationToHome()
        case .setting:
            return self.navigationToSetting()
        case .settingSubmit:
            return self.popToSettingViewController()
        default:
            return .none
        }
    }
    
    func navigationToHome() -> FlowContributors {
        let reactor = HomeReactor()
        let vc = HomeViewController(reactor: reactor)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    
    func navigationToSetting() -> FlowContributors {
        let reactor = SettingReactor()
        let vc = SettingViewController(reactor: reactor)
        
        vc.hidesBottomBarWhenPushed = true
        
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: vc,
            withNextStepper: vc.reactor!)
        )
    }
    
    func popToSettingViewController() -> FlowContributors {
        
        // TODO: - Pop방식을 VC를 받아서 처리하는 것으로 바꿔보기.
        UIApplication.topViewController()?.navigationController?.popViewController(animated: true)
        return .none
    }
}
