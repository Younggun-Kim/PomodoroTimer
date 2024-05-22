//
//  HomeReactor.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import Foundation
import RxSwift
import RxFlow
import RxRelay
import ReactorKit

class HomeReactor: Reactor, Stepper {
    
    var disposeBag = DisposeBag()
    var recordRelay: PublishRelay<RecordModel>
    
    init(recordRelay: PublishRelay<RecordModel>) {
        self.recordRelay = recordRelay
        
        self.recordRelay
            .map { Action.receiveRecordData($0)}
            .bind(to: action)
            .disposed(by: self.disposeBag)
    }
    
    deinit {
    }
    
    // MARK: Stepper
    
    let steps = PublishRelay<Step>()
    
    
    var initialStep: Step {
        return NavigationStep.homeIsRequired
    }
    
    
    // MARK: Reactor
    
    enum Action: Equatable {
        case play
        case pause
        case setting
        case receiveRecordData(RecordModel)
    }
    
    enum Mutation {
        case setTime(Int)
        case setRunning(Bool)
        case moveSetting
        case setData(RecordModel)
    }
    
    struct State {
        var goal: String = ""
        
        var currentTime: Int = 0
        
        var isRunning: Bool = false
    }
    
    var initialState = State()
    
    var timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .play:
            return Observable.concat([
                Observable.just(Mutation.setRunning(true)),
                self.startTimer()
            ])
        case .pause:
            return Observable.just(Mutation.setRunning(false))
        case .setting:
            return Observable.just(Mutation.moveSetting)
        case let .receiveRecordData(data):
            return .just(.setData(data))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setTime(time):
            state.currentTime = time
        case let .setRunning(isRunning):
            state.isRunning = isRunning
        case .moveSetting:
            self.steps.accept(NavigationStep.moveSetting)
        case let .setData(data):
            state.goal = data.goal
            
            // TODO: - 이거 시간 설정 코드 바꿔야함.
            state.currentTime = data.minute
        }
        
        return state
    }
    
    private func startTimer() -> Observable<Mutation> {
        return Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(until: self.action.filter({ $0 == .pause }))
            .take(while: { _ in self.currentState.currentTime < 5})
            .map { _ in Mutation.setTime(self.currentState.currentTime + 1)}
    }
}
