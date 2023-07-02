//
//  TheComposableArchitectureApp.swift
//  TheComposableArchitecture
//
//  Created by 김동욱 on 2023/07/01.
//

import SwiftUI

import ComposableArchitecture

@main
struct TheComposableArchitectureApp: App {
    
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges() // 액션을 수행한 후의 상태 변화 추적(콘솔 출력)
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: TheComposableArchitectureApp.store)
        }
    }
}
