let sliceName = "counter3"

type state = {value3: int}
let initState: state = {
  value3: 0,
}

type action =
  | Increment
  | IncrementByAmount3(int)
  | Decrement


let reducer = ({value3}: state, a: action) =>{
  switch a {
  | Increment => {value3: value3 + 1}
  | IncrementByAmount3(amount) => {value3: value3 + amount}
  | Decrement => {value3: value3 - 1}
  }
}

// TODO any other new ideas to list all action name as string?
let reducerActions: array<action> = [Increment, IncrementByAmount3(0), Decrement]
let slice = RTK.createSliceWithActionArray(sliceName, initState, (reducer, reducerActions))

// let useState = () => slice->RTK.useStateOf(initState)
// let useDispatch = () => slice->RTK.useDispatchOf(reducerActions)

let use = () => (
  slice->RTK.useStateOf(initState),
  slice->RTK.useDispatchOf(reducerActions)
)

