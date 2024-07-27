// import { configureStore } from '@reduxjs/toolkit';
// import counterReducer from './CounterSlice.res.mjs';

// const store = configureStore({
//   reducer: {
//     counter: counterReducer.reducer,
//   },
// });

// export default store;

open RTK


type configureStoreType = {
  reducer: JSON.t
}

type allState
type allAction

@module("@reduxjs/toolkit") 
external configureStore: (configureStoreType) => Redux.store<allState,allAction> = "configureStore"

let createReducers: array<Js.Dict.t<RescriptCore.JSON.t>> => JSON.t =  %raw(`
 (reducers) => {
   const r = {}
   reducers.forEach(reducer => {
    if (reducer && reducer.name) {
      r[reducer.name] = reducer["reducer"]
    }
   });
   return r;
}`)

let store = configureStore({
  reducer: createReducers([CounterSlice.counterSlice]),
});

