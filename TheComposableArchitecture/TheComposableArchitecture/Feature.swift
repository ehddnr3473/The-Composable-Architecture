//
//  Feature.swift
//  TheComposableArchitecture
//
//  Created by 김동욱 on 2023/07/01.
//

import Foundation

import ComposableArchitecture

struct Feature: ReducerProtocol {
    
    struct State: Equatable {
        var count = 0;
        var numberFactAlert: String?
    }
    
    enum Action: Equatable {
        case factAlertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .factAlertDismissed:
            state.numberFactAlert = nil
            /*
             <
             An effect that does nothing and completes immediately. Useful for situations where you must return an effect, but you don’t need to do anything.
             */
            return .none
            
        case .decrementButtonTapped:
            state.count -= 1
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            return .none
            
        case .numberFactButtonTapped:
            return .run { [count = state.count] send in
                let (data, _) = try await URLSession.shared.data(
                    from: URL(string: "http://numbersapi.com/\(count)/trivia")!
                )
                await send(
                    .numberFactResponse(String(decoding: data, as: UTF8.self))
                )
            }
            
        case let .numberFactResponse(fact):
            state.numberFactAlert = fact
            return .none
        }
    }
}
