//
//  SplashViewController.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/19/24.
//

import UIKit
import Reusable
import ReactorKit
import RxFlow
import RxRelay

class SplashViewController: UIViewController, View {
    
    
    // MARK: ReactorKit
    typealias Reactor = SplashReactor
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: SplashReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: - View
    
    var timer = PublishRelay<Bool>()
    
    init(reactor: SplashReactor!) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer.accept(true)
    }
}


extension SplashViewController {
    func bindAction(reactor: SplashReactor) {
        self.timer
            .filter { $0 == true }
            .delay(.seconds(3), scheduler: MainScheduler.instance)
            .map { _ in Reactor.Action.timeOut}
            .debug()
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func bindState(reactor: SplashReactor) {
        
    }
}
