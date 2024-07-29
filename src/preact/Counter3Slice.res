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
  switch a {
  | Increment => {value3: value3 + 1}
  | IncrementByAmount(amount) => {value3: value3 + amount}
  | Decrement => {value3: value3 - 1}
  }
}

// 方式１ any other new ideas to list all action name as string?
let reducerActions: array<action> = [Increment, IncrementByAmount(0), Decrement]
let slice = RTK.createSliceWithActionArray(sliceName, initState, (reducer, reducerActions))

// 方式２
// let actionCreators = {
//   increment:  () => Increment,
//   incrementByAmount: (amount: int) => IncrementByAmount(amount),
//   decrement: () => Decrement,
// }
// let slice = RTK.createSlice3("counter2", initState, (reducer, actionCreators))

// let useState = () => slice->RTK.useStateOf(initState)
// let useDispatch = () => slice->RTK.useDispatchOf(reducerActions)

let use = () => (
  slice->RTK.useStateOf(initState),
  slice->RTK.useDispatchOf(reducerActions)
)
