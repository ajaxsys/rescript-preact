// Define Rs types
type state = {value: int}
let initState: state = {
  value: 0,
}

type action =
  | Increment
  | IncrementByAmount(int)
  | Decrement

let reducer = ({value}: state, a: action) =>{
  Console.log("Rs reducer caled")
  switch a {
  | Increment => {value: value + 1}
  | IncrementByAmount(amount) => {value: value + amount}
  | Decrement => {value: value - 1}
  }
}

type sliceActions<'action> = {
  increment: unit => 'action,
  incrementByAmount: int => 'action,
  decrement: unit => 'action,
}

// TODO any other new ideas to list all action name as string?
// let reducerActions = [Increment, IncrementByAmount(0), Decrement]
// let counterSlice = RTK.createSlice2("counter2", initState, (reducer, reducerActions))

let actionCreators = {
  increment:  () => Increment,
  incrementByAmount: (amount: int) => IncrementByAmount(amount),
  decrement: () => Decrement,
}
let counterSlice = RTK.createSlice3("counter2", initState, (reducer, actionCreators))

let useState: unit => state = () => counterSlice->RTK.toState

let actions: sliceActions<action> = counterSlice->RTK.toActions
let decrementAction = actions.decrement()

let {increment, incrementByAmount, decrement} = actions

