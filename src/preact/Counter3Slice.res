let sliceName = "counter3"

// Define Rs types
type state = {value3: int}
let initState: state = {
  value3: 0,
}

type action =
  | Increment
  | IncrementByAmount(int)
  | Decrement


let reducer = ({value3}: state, a: action) =>{
  Console.log("Rs reducer caled")
  switch a {
  | Increment => {value3: value3 + 1}
  | IncrementByAmount(amount) => {value3: value3 + amount}
  | Decrement => {value3: value3 - 1}
  }
}

// 方式１ any other new ideas to list all action name as string?
let reducerActions: array<action> = [Increment, IncrementByAmount(0), Decrement]
let counterSlice = RTK.createSliceWithActionArray(sliceName, initState, (reducer, reducerActions))

// 方式２
// let actionCreators = {
//   increment:  () => Increment,
//   incrementByAmount: (amount: int) => IncrementByAmount(amount),
//   decrement: () => Decrement,
// }
// let counterSlice = RTK.createSlice3("counter2", initState, (reducer, actionCreators))

let useState: unit => state = () => counterSlice->RTK.toState

let useDispatch: unit => RTK.useDispatchReturnType<action> = () => {
  let dispatch = RTK.useDispatch()
  (action) => {
    dispatch(counterSlice->RTK.action(action))
  }
}

let use = () => (useState(), useDispatch())
