//
//  RetrospectViewController.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/23/24.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import RxRelay


// 회고 화면
class RetrospectViewController: BaseVC, View {
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerCloseButton: UIButton!
    @IBOutlet weak var goodWrapperView: UIView!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var badWrapperView: UIView!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - ReactorKit
    
    typealias Reactor = RetrospectReactor
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: RetrospectReactor) {
        guard self.isViewLoaded else {
            return
        }
        
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    
    // MARK: - View
    
    init(reactor: RetrospectReactor!) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConfig()
        self.bind(reactor: self.reactor!)
    }
    
    private func setConfig() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.7)
        
        self.containerView.do {
            $0.layer.cornerRadius = 16
            $0.layer.masksToBounds = true
            $0.clipsToBounds = true
            $0.backgroundColor = .white
        }
        
        [self.goodWrapperView,
         self.badWrapperView]
            .compactMap{ $0 }
            .forEach {
            $0.layer.cornerRadius = $0.frame.height * 0.5
        }
        
        self.descriptionTextView.do {
            $0.layer.cornerRadius = 16
            $0.backgroundColor = .systemGray
        }
    }
}


extension RetrospectViewController {
    
    private func bindAction(reactor: RetrospectReactor) {
        
        self.headerCloseButton
            .rx
            .tap
            .map { RetrospectReactor.Action.onTapClose }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func bindState(reactor: RetrospectReactor) {
        let state = reactor.state
    }
}
