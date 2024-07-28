// Define Rs types
type state = {value: int}
let initState: state = {
  value: 0,
}

type action =
  | Increment
  | IncrementByAmount(int)
  | Decrement

let reducer = ({value}: state, a: action): state =>
  switch a {
  | Increment => {value: value + 1}
  | IncrementByAmount(amount) => {value: value + amount}
  | Decrement => {value: value - 1}
  }

let m: Map.t<action, (state, action) => state> = Map.make()
m -> Map.set(Increment, (s, a) => reducer(s, a))
m -> Map.set(IncrementByAmount(2), (s, a) => reducer(s, a))
m -> Map.set(Decrement, (s, a) => reducer(s, a))

type slice<'state> = {
  name: string,
  initialState: 'state,
}

let counterSlice = RTK.createSlice2("counter", initState, reducer)


