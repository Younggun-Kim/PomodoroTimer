//
//  HomeViewController.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import UIKit
import Reusable
import RxSwift
import ReactorKit

class HomeViewController: UIViewController, ReactorBased, StoryboardBased {
    typealias Reactor = HomeReactor
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: HomeReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    init(reactor: HomeReactor!) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController {
    
    func bindAction(reactor: HomeReactor) {
        
    }
    
    func bindState(reactor: HomeReactor) {
        
    }
}
