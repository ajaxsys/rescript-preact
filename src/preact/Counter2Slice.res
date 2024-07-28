// Define Rs types
type state = {value: int}
let initState: state = {
  value: 0,
}

type action =
  | Increment
  | IncrementByAmount(int)
  | Decrement

let reducer = ({value}: state, a: action) =>
  switch a {
  | Increment => {value: value + 1}
  | IncrementByAmount(amount) => {value: value + amount}
  | Decrement => {value: value - 1}
  }

type slice<'state> = {
  name: string,
  initialState: 'state,
}

// TODO any other new ideas to list all action name as string?
let reducerActions = [Increment, IncrementByAmount(0), Decrement]

let counterSlice = RTK.createSlice2("counter2", initState, (reducer, reducerActions))


