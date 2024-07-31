let sliceName = "counter3"

type state = {value3: int}
let initState: state = {
  value3: 0,
}

type action =
  | Increment
  | IncrementByAmount(int)
  | Decrement

let reducer = ({value3}: state, a: action) => {
  switch a {
  | Increment => {value3: value3 + 1}
  | IncrementByAmount(amount) => {value3: value3 + amount}
  | Decrement => {value3: value3 - 1}
  }
}

%%private(
  // TODO any other new ideas to list all action name as string?
  let initActions: array<action> = [Increment, IncrementByAmount(0), Decrement]
)
let slice = RTK.createSliceWithActionArray(sliceName, initState, reducer, initActions)

// let useState = () => slice->RTK.useStateOf(initState)
// let useDispatch = () => slice->RTK.useDispatchOf(initActions)

let use = () => (
  slice->RTK.useStateOf(initState),
  slice->RTK.useDispatchOf(initActions)
)
