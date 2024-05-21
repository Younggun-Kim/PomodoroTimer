//
//  HomeViewController.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import ReactorKit
import HGCircularSlider
import Then

class HomeViewController: UIViewController, ReactorBased, StoryboardBased {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var circularSlider: CircularSlider!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    
    // MARK: - ReactorKit
    
    typealias Reactor = HomeReactor
    
    var disposeBag = DisposeBag()
    
    // MARK: - View
    
    // date formatter user for timer label
    let dateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        
        return formatter
    }()
    
    init(reactor: HomeReactor!) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
        
        if let reactor = self.reactor {
            self.bind(reactor: reactor)
        }
    }
    
    private func configView() {
        self.circularSlider.do {
            $0.minimumValue = 0.0
            $0.maximumValue = 60.0
            $0.endPointValue = 30
            $0.diskFillColor = .red
            $0.diskColor = .white
            $0.lineWidth = 12
            $0.backtrackLineWidth = 12
            $0.trackFillColor = .green
            $0.trackColor = .gray.withAlphaComponent(0.3)
            
            $0.isUserInteractionEnabled = false
            $0.thumbLineWidth = 0.0
            $0.thumbRadius = 0.0
        }
        
        self.timeLabel.do {
            var components = DateComponents()
            components.second = Int(30)
            $0.text = dateComponentsFormatter.string(from: components)
            $0.font = .systemFont(ofSize: 30, weight: .bold)
        }
    }
    
    // MARK: Bind Reactor
    func bind(reactor: HomeReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    func bindAction(reactor: HomeReactor) {
        playBtn?
            .rx
            .tap
            .map { HomeReactor.Action.play }
            .debug()
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        pauseBtn?
            .rx
            .tap
            .map { HomeReactor.Action.pause}
            .debug()
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func bindState(reactor: HomeReactor) {
        
        guard let slider = circularSlider else {
            return
        }
        
        reactor
            .state
            .compactMap { $0.currentTime }
            .map { CGFloat($0) }
            .bind(to: circularSlider.rx.endPointValue)
            .disposed(by: self.disposeBag)
        
        reactor
            .state
            .map { $0.currentTime }
            .compactMap { [weak self] (currentTime: Int) in
                var components = DateComponents()
                components.second = currentTime
                return self?.dateComponentsFormatter.string(from: components)
            }
            .bind(to: timeLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}

extension HomeViewController {
    
}
