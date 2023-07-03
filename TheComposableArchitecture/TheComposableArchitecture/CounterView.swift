//
//  CounterView.swift
//  TheComposableArchitecture
//
//  Created by 김동욱 on 2023/07/01.
//

import SwiftUI

import ComposableArchitecture

struct CounterView: View {
    /*
     Store
     * Feature의 runtime을 표현
     * 상태를 업데이트하기 위해서 액션을 처리하며, effect를 실행하고, 그 effect를 실행함으로써 만들어진 데이터를 시스템에 다시 공급하는 객체
     * Store는 뷰에 의해서 관찰될 필요가 없기 때문에 let으로 선언함.
     */
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                
                HStack {
                    Button("-") { viewStore.send(.decrementButtonTapped)}
                        .font(.largeTitle)
                        .padding()
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                    
                    Button("+") { viewStore.send(.incrementButtonTapped)}
                        .font(.largeTitle)
                        .padding()
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Button("Number fact") { viewStore.send(.numberFactButtonTapped) }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                
                if viewStore.isLoading {
                    ProgressView()
                } else if let fact = viewStore.fact {
                    Text(fact)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
//            .alert(
//                item: viewStore.binding(
//                    get: { $0.numberFactAlert.map(FactAlert.init(title: )) },
//                    send: .factAlertDismissed
//                ),
//                content: { Alert(title: Text($0.title)) })
        }
    }
    
//    struct FactAlert: Identifiable {
//        var title: String
//        var id: String { self.title }
//    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        CounterView(store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        })
    }
}
