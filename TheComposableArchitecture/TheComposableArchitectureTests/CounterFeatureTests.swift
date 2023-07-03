//
//  CounterFeatureTests.swift
//  TheComposableArchitectureTests
//
//  Created by 김동욱 on 2023/07/03.
//

import XCTest
@testable import TheComposableArchitecture

import ComposableArchitecture

/*
 @MainActor
 
 A store initialized on a non-main thread. …

 The "Store" class is not thread-safe, and so all interactions with an instance of "Store" (including all of its scopes and derived view stores) must be done on the main thread.
 */
@MainActor
final class CounterFeatureTests: XCTestCase {
    
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.decrementButtonTapped) { // @MainActor method
            // 액션을 처리한 후의 상태 값을 유추
            // [relative mutation : '$0.count -= 1'] 보다,
            // 명확한 상태를 유추하는 [absolute mutation: '$0.count = -1']을 사용할 것을 권장함.
            $0.count = -1
        }
        
        XCTAssertEqual(store.state.count, -1)
        
        await store.send(.incrementButtonTapped) {
            $0.count = 0
        }
        
        XCTAssertEqual(store.state.count, 0)
    }
}
