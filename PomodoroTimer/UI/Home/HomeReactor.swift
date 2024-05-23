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
        case showRetrospectPopup
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
            //            state.currentTime = data.minute * 60
            state.currentTime = data.minute
        case .showRetrospectPopup:
            self.steps.accept(NavigationStep.showRetrospect)
            
        }
        
        return state
    }
    
    private func startTimer() -> Observable<Mutation> {
        return Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(until: self.action.filter({ $0 == .pause }))
            .take(while: { _ in self.currentState.currentTime > 0})
            .flatMap { _ -> Observable<Mutation> in
                let newTime = self.currentState.currentTime - 1
                if newTime == 0 {
                    
                    // TODO: CoreData 생성을 여기서 해야하나..? 그러면 팝업에 id를 넘겨줘서 저장한 걸 수정해아 할 것 같은데
                    return Observable.concat([
                        .just(.setTime(newTime)),
                        .just(.showRetrospectPopup)
                    ])
                } else {
                    return .just(.setTime(newTime))
                }
            }
        
    }
}
