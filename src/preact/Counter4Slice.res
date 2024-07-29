let sliceName = "counter4"

// Define Rs types
type state = {value4: int}
let initState: state = {
  value4: 0,
}

type action =
  | Increment
  | IncrementByAmount(int)
  | Decrement


let reducer = ({value4}: state, a: action) =>{
  Console.log("Rs reducer caled")
  switch a {
  | Increment => {value4: value4 + 1}
  | IncrementByAmount(amount) => {value4: value4 + amount}
  | Decrement => {value4: value4 - 1}
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
let useDispatch = () => RTK.useDispatchOf(counterSlice, reducerActions)

let use = () => (useState(), useDispatch())
