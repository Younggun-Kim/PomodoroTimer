//
//  SettingViewController.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/22/24.
//

import UIKit
import ReactorKit
import RxSwift


/**
 시간 설정 화면
 */
class SettingViewController: BaseVC, ReactorBased {
    
    // MARK: - ReactorKit
    
    var disposeBag = DisposeBag()
    
    typealias Reactor = SettingReactor
    
    func bind(reactor: SettingReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    
    // MARK: - View
    
    // 초기화 여부.
    private var isInit = false
    
    init(reactor: SettingReactor!) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.isInit == false,
           let reactor = self.reactor {
            self.isInit = true
            self.disposeBag = DisposeBag()
            self.bind(reactor: reactor)
        }
    }
}


extension SettingViewController {
    private func bindAction(reactor: SettingReactor) {
        
    }
    
    private func bindState(reactor: SettingReactor) {
        
    }
}
