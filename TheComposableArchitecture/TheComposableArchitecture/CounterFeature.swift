//
//  CounterFeature.swift
//  TheComposableArchitecture
//
//  Created by 김동욱 on 2023/07/01.
//

import Foundation

import ComposableArchitecture

struct CounterFeature: ReducerProtocol {
    
    /// Feature가 작업을 수행하는 데 필요한 상태를 유지하는 타입(일반적으로 struct)
    /// 단일 정수형 데이터로 구성된 상태
    struct State: Equatable {
        var count = 0;
        var numberFactAlert: String?
    }
    
    /// Feature에서 사용자가 수행할 수 있는 모든 액션을 기술하는 타입(일반적으로 enum)
    /// Action의 case 이름은 로직[ ex) incrementCount ]보다는 사용자가 UI에서 행하는 작업에 초점을 맞춰서 지을 것.
    enum Action: Equatable {
        case factAlertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
    }
    
    /// 현재 값에서 다음 값으로 상태를 변화시키기 위한 메서드. 외부에서 실행하기를 원하는 effect를 반환함.
    /// switch문을 사용, 들어오는 액션을 분류해서 로직을 수행.
    /// - Parameters:
    ///   - state: 상태에 변화를 주기위해 즉각적으로 변형을 일으키기 위해 inout 사용
    ///   - action: 액션 분류
    /// - Returns: 외부에서 실행할 Effect를 표현하는 값
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .factAlertDismissed:
            state.numberFactAlert = nil
            /*
             An effect that does nothing and completes immediately.
             Useful for situations where you must return an effect, but you don’t need to do anything.
             
             * 이 case에서, 아무것도 수행할 필요가 없음. 따라서 none 반환
             * none: 수행할 effect 없음을 표현.
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
