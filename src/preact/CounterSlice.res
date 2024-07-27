// @module("redux-toolkit") 
// external createSlice: (JSON.t) => JSON.t = "createSlice"

// @module("redux-toolkit") 
// external configureStore: (Js.Dict.t<'a>) => Js.Dict.t<'a> = "configureStore"

type state = {
  value: int
}
let emptyState = {
  value: 1
}

type action<'state> = {
  increment: (state) => state, // Can draft in js, so JS can update it & NO need to return anything
  decrement: (state) => state, // Can draft in js, so JS can update it & NO need to return anything
}

type slice<'state> = {
  name: string,
  initialState: 'state,
  actions: action<'state>,
  reducer?: RTK.Redux.reducer<'state, 'state>
}

@module("@reduxjs/toolkit") 
external createSlice: (slice<'a>) => Js.Dict.t<JSON.t> = "createSlice"

let stateslice: slice<state> = {
  name: "counter",
  initialState: emptyState,
  actions: {
    increment: (state) => {value: state.value + 1},
    decrement: (state) => {value: state.value - 1}
  },
}

let counterSlice = createSlice(stateslice)

// For export
// type action<'a> = {
//   increment: (int, 'a) => int,
//   decrement: (int, 'a) => int,
// }
let actions = counterSlice->Js.Dict.get("actions")
let reducer = counterSlice->Js.Dict.get("reducer")

Console.log2("actions", actions)
Console.log2("reducer", reducer)