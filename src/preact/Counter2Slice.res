let sliceName = "counter2"

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
// let slice = RTK.createSlice2("counter2", initState, (reducer, reducerActions))

let actionCreators = {
  increment:  () => Increment,
  incrementByAmount: (amount: int) => IncrementByAmount(amount),
  decrement: () => Decrement,
}
let slice = RTK.createSliceWithActionMapping(sliceName, initState, (reducer, actionCreators))

let actions: sliceActions<action> = slice->RTK.toActions
let {increment, incrementByAmount, decrement} = actions

// let useState = () => slice->RTK.useStateOf(initState)
// let useDispatch = () => RTK.useDispatch()

let use = () => (
  slice->RTK.useStateOf(initState), 
  RTK.useDispatch()
)
