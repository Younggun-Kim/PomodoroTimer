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
        case inputText(String)
        case minutePickerSelected(Int)
        case submit
    }
    
    enum Mutation {
        case setGoal(String)
        case setSelectedMinuteIndex(Int)
        case popVC
        case setSubmitEnabled
    }
    
    struct State {
        var minutes = Array(stride(from: 5, to: 61, by: 5))

        var selectedMinuteIndex = 0
        
        var goal: String = ""
        
        var isEnabledSubmit = false
    }
    
    var initialState = State()
}

extension SettingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .inputText(goal):
            return Observable.concat([
                .just(.setSubmitEnabled),
                .just(.setGoal(goal)),
            ])
        case let .minutePickerSelected(row):
            return .just(.setSelectedMinuteIndex(row))
        case .submit:
            return .just(.popVC)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setGoal(goal):
            state.goal = goal
        case let .setSelectedMinuteIndex(row):
            state.selectedMinuteIndex = row
        case .popVC:
            if state.isEnabledSubmit {
                let minute = state.minutes[state.selectedMinuteIndex]
                let record = RecordModel(goal: state.goal, minute: minute)
                self.steps.accept(NavigationStep.settingSubmit(record))
            }
        case .setSubmitEnabled:
            // TODO: - 이벤트 처리가 한 박자씩 느리넹
            state.isEnabledSubmit = state.goal.count >= 2
        }
        
        return state
    }
}
