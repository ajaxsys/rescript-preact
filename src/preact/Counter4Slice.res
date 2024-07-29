let sliceName = "counter4"

type state = {value4: int}
let initState: state = {
  value4: 0,
}

type action =
  | Increment
  | IncrementByAmount4(int)
  | Decrement


let reducer = ({value4}: state, a: action) =>{
  switch a {
  | Increment => {value4: value4 + 1}
  | IncrementByAmount4(amount) => {value4: value4 + amount}
  | Decrement => {value4: value4 - 1}
  }
}

// TODO any other new ideas to list all action name as string?
let reducerActions: array<action> = [Increment, IncrementByAmount4(0), Decrement]
let slice = RTK.createSliceWithActionArray(sliceName, initState, (reducer, reducerActions))

// let useState = () => slice->RTK.useStateOf(initState)
// let useDispatch = () => slice->RTK.useDispatchOf(reducerActions)

let use = () => (
  slice->RTK.useStateOf(initState),
  slice->RTK.useDispatchOf(reducerActions)
)

