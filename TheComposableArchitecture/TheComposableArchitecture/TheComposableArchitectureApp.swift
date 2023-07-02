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
    var body: some Scene {
        WindowGroup {
            FeatureView(
                store: Store(initialState: Feature.State()) {
                    Feature()
                }
            )
        }
    }
}
