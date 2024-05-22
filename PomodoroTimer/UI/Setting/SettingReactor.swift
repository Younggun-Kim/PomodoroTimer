//
//  SettingReactor.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/22/24.
//

import Foundation
import ReactorKit
import RxSwift
import RxFlow
import RxRelay


class SettingReactor: Reactor, Stepper {
    
    init() {
    }
    
    // MARK: - RxFlow Stepper
    
    var steps = PublishRelay<Step>()
    
    
    // MARK: - Reactor
    
    enum Action {
        case submit
        case inputText(String)
        case minutePickerSelected(Int)
    }
    
    enum Mutation {
        case popVC
        case setGoal(String)
        case updateSelectedMinute(Int)
    }
    
    struct State {
        var minutes = (1...12).map { $0 * 5 }
        
        var goal: String = ""
        
        var selectedMinute: Int?
    }
    
    var initialState = State()
}

extension SettingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .submit:
            return .just(.popVC)
        case let .inputText(goal):
            return .just(.setGoal(goal))
        case let .minutePickerSelected(minute):
            return .just(.updateSelectedMinute(minute))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .popVC:
            if let selectedMinute = state.selectedMinute {
                let record = RecordModel(goal: state.goal, minute: selectedMinute)
                self.steps.accept(NavigationStep.settingSubmit(record))
            } else {
                // 알럿 띄워야 함.
            }
        case let .setGoal(goal):
            state.goal = goal
        case let .updateSelectedMinute(minute):
            state.selectedMinute = minute
        }
        
        return state
    }
}
