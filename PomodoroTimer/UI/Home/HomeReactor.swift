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
    
    // MARK: Stepper
    
    let steps = PublishRelay<Step>()
    
    
    var initialStep: Step {
        return NavigationStep.homeIsRequired
    }
    
    
    // MARK: Reactor
    
    enum Action {
        case play
        case pause
        case setting
    }
    
    enum Mutation {
        case setTime(Int)
        case setRunning(Bool)
        case moveSetting
    }
    
    struct State {
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
            self.steps.accept(NavigationStep.setting)
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
