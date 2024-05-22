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
class SettingViewController: BaseVC, View, UIPickerViewDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var focusTimeLabel: UILabel!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var minutePickerView: UIPickerView!
    @IBOutlet weak var settingButton: UIButton!
    
    
    // MARK: - ReactorKit
    
    var disposeBag = DisposeBag()
    
    typealias Reactor = SettingReactor
    
    func bind(reactor: SettingReactor) {
        guard self.isInit == true else {
            return
        }
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
        self.setConfig()
        
        if self.isInit == false,
           let reactor = self.reactor {
            self.isInit = true
            self.disposeBag = DisposeBag()
            self.bind(reactor: reactor)
        }
    }
    
    private func setConfig() {
        self.goalLabel.do {
            $0.font = .systemFont(ofSize: 20, weight: .bold)
        }
        
        self.focusTimeLabel.do {
            $0.font = .systemFont(ofSize: 20, weight: .bold)
        }
        
        self.minutePickerView.do {
            $0.rx.setDelegate(self).disposed(by: self.disposeBag)
        }
    }
}


extension SettingViewController {
    private func bindAction(reactor: SettingReactor) {
        self.settingButton
            .rx
            .tap
            .map { SettingReactor.Action.submit }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func bindState(reactor: SettingReactor) {
        reactor
            .state
            .map { $0.minutes }
            .bind(to: minutePickerView.rx.itemTitles) { (row, element) in
                return "\(element) min"
            }
            .disposed(by: disposeBag)
    }
}
