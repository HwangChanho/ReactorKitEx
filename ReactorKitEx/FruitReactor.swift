//
//  FruitReactor.swift
//  ReactorKitEx
//
//  Created by AlexHwang on 2022/12/07.
//

import Foundation
import ReactorKit

class FruitReactor: Reactor {
    // MARK: Actions
    enum Action {
        case apple
        case banana
        case grapes
    }
    
    enum Mutation {
        case appleLabel
        case bananaLabel
        case grapesLabel
        case setLoading(Bool)
    }
    
    // MARK: State
    struct State {
        var fruitName: String
        var isLoading: Bool
    }
    
    // MARK: Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .apple:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.appleLabel).delay(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        case .banana:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.bananaLabel).delay(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        case .grapes:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.grapesLabel).delay(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    // MARK: Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .appleLabel:
            state.fruitName = "사과"
        case .bananaLabel:
            state.fruitName = "바나나"
        case .grapesLabel:
            state.fruitName = "포도"
        case .setLoading(let val):
            state.isLoading = val
        }
        
        return state
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(fruitName: "선택되어진 과일 없음", isLoading: false)
    }
}
