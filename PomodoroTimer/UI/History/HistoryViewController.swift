//
//  HistoryViewController.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import UIKit
import Reusable
import ReactorKit
import RxSwift


class HistoryViewController: UIViewController, ReactorBased, StoryboardBased {
    typealias Reactor = HistoryReactor
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: HistoryReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    init(reactor: HistoryReactor!) {
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

extension HistoryViewController {    
    func bindAction(reactor: HistoryReactor) {
        
    }
    
    func bindState(reactor: HistoryReactor) {
        
    }
}
