let sliceName = "counter4"

type state = {value4: int}
let initState: state = {
  value4: 0,
}

type action =
  | Increment
  | IncrementByAmount(int)
  | Decrement
  | Decrement2

let reducer = ({value4}: state, a: action) => {
  switch a {
  | Increment => {value4: value4 + 1}
  | IncrementByAmount(amount) => {value4: value4 + amount}
  | Decrement => {value4: value4 - 1}
  | Decrement2 => {value4: value4 - 2}
  }
}

module TypeSafe: {let actions: array<action>} = {
  type aCopyOfActionType =
    | Increment
    | IncrementByAmount(int)
    | Decrement
    | Decrement2
    // If you forgot to add a type to array, you will got a warning
    // https://forum.rescript-lang.org/t/is-there-a-way-to-get-the-name-of-variant-in-type/4420/7
  let actions = ([Increment, IncrementByAmount(0), Decrement] :> array<action>)
}

let slice = RTK.createSliceWithActionArray(sliceName, initState, (reducer, TypeSafe.actions))
let use = () => (slice->RTK.useStateOf(initState), slice->RTK.useDispatchOf(TypeSafe.actions))
