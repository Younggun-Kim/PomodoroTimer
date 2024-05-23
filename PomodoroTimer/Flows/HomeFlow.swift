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
        case .moveSetting:
            return self.navigationToSetting()
        case let .settingSubmit(record):
            return self.popToSettingViewController(sendData: record)
        case .showRetrospect:
            return self.presentToRetrospect()
        case .dismissRetrospect:
            return self.dismissToRetrospect()
        default:
            return .none
        }
    }
    
    func navigationToHome() -> FlowContributors {
        let reactor = HomeReactor(recordRelay: self.settingDataResponseRelay)
        let vc = HomeViewController.instantiate(withReactor: reactor)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    
    func navigationToSetting() -> FlowContributors {
        let reactor = SettingReactor()
        let vc = SettingViewController.instantiate(withReactor: reactor)
        
        vc.hidesBottomBarWhenPushed = true
        
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: vc,
            withNextStepper: vc.reactor!)
        )
    }
    
    // TODO: Pop을 vc를 찾아서 하는 걸로 바꾸는게 좋겠지?? 메이비?
    func popToSettingViewController(sendData data: RecordModel) -> FlowContributors {
        self.settingDataResponseRelay.accept(data)
        self.rootViewController.popViewController(animated: true)
        return .none
    }
    
    func presentToRetrospect() -> FlowContributors {
        let reactor = RetrospectReactor()
        let vc = RetrospectViewController.instantiate(withReactor: reactor)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.rootViewController.present(vc, animated: true)
        
        return .one(flowContributor: .contribute(
            withNextPresentable: vc,
            withNextStepper: vc.reactor!)
        )
    }
    
    func dismissToRetrospect() -> FlowContributors {
        self.rootViewController.dismiss(animated: true)
        return .none
    }
}
