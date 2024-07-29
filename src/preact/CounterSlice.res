// Define Rs types
type state = {value: int}
let initialState: state = {
  value: 0,
}

type action =
  | Increment
  | IncrementByAmount(int)
  | Decrement

let reducer = (state: state, action: action): state => {
  switch action {
  | Increment => {value: state.value + 1}
  | IncrementByAmount(amount) => {value: state.value + amount}
  | Decrement => {value: state.value - 1}
  }
}

type sliceActions<'action> = {
    increment: unit => 'action,
    incrementByAmount: int => 'action,
    decrement: unit => 'action,
  }

type slice<'state, 'action> = {
  name: string,
  initialState: 'state,
  reducer: ('state, 'action) => 'state,
  actions: sliceActions<'action>,
}

let createSlice = (name: string, initialState: state) => {
  let increment = () => Increment
  let incrementByAmount = (amount: int) => IncrementByAmount(amount)
  let decrement = () => Decrement
  
  {
    name: name,
    initialState: initialState,
    reducer: reducer,
    actions: {
      increment: increment,
      incrementByAmount: incrementByAmount,
      decrement: decrement,
    }
  }
}

let counterSlice = createSlice("counter", initialState)

let useState: unit => state = () => counterSlice->RTK.toState
