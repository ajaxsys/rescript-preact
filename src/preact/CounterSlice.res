// @module("redux-toolkit") 
// external createSlice: (JSON.t) => JSON.t = "createSlice"

// @module("redux-toolkit") 
// external configureStore: (Js.Dict.t<'a>) => Js.Dict.t<'a> = "configureStore"

type action<'a> = {
  increment: (int, 'a) => int,
  decrement: (int, 'a) => int,
}

type slice<'a> = {
  name: string,
  initialState: int,
  actions: action<'a>,
  reducer?: RTK.Redux.reducer<'a, 'a>
}

@module("@reduxjs/toolkit") 
external createSlice: (slice<'a>) => Js.Dict.t<JSON.t> = "createSlice"

let stateslice: slice<int> = {
  name: "counter",
  initialState: 0,
  actions: {
    increment: (state, int) => state + int,
    decrement: (state, int) => state - int,
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