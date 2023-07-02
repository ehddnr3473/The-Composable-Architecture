# The-Composable-Architecture

## What is the Composable Architecture?

- **State management**
  <br> 값 타입을 사용하는 애플리케이션의 상태(State)를 관리하고, 특정 화면에서 변한 상태를 다양한 화면에서 관찰하고 공유하는 방법
  
- **Composition**
  <br> 거대한 기능(Feature)을 작은 컴포넌트로 나누고, 모듈을 독립시키고, Feature를 구성하기 위해 쉽게 붙이는 방법
  
- **Side effects**
  <br> 애플리케이션의 특정 부분이 테스트할 수 있고 이해할 수 있는 방식으로 외부와 소통하는 방법
  
- **Testing**
  <br> 아키텍처 내의 Feature를 테스트할 뿐만이 아니라, 애플리케이션에 영향을 주는 side effect를 이해하기 위해, 다른 부분과 구성되는 기능을 테스트하는 Integration test, 그리고 end-to-end 테스트를 수행하는 방법

<br>

## TCA를 사용해서 Feature를 만들기 위해 정의해야 할, 도메인을 모델링하는 타입과 값

- **State**: Feature에서 로직을 수행하거나 UI에 렌더링 되는 데이터를 기술하는 타입
  
- **Action**: 사용자 action, notification, event source 등, Feature에서 일어날 수 있는 모든 행동을 표현하는 타입
  
- **Reducer**: 주어진 액션으로 현재 상태에서 다음 상태로 가는 방법을 기술하는 function. reducer는 **Effect**값을 반환함으로써 완료될 수 있는 API 요청 등, 수행할 수 있는 effects를 반환할 책임이 있음.
  
- **Store**: Feature를 관리하는 런타임. 모든 사용자 액션을 Store로 보내고, Store는 reducer와 effect를 수행하고, Store 내에서 상태 변화를 관찰하고 UI를 업데이트할 수 있음.

<br> 위와 같이 나누면 Feature의 테스트 가능성을 높이고, 크고 복잡한 기능을 분리하고 붙일 수 있는 작은 도메인으로 나눌 수 있음.
