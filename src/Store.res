let slices = [
  Counter2Slice.counterSlice, 
  Counter3Slice.counterSlice,
  Counter4Slice.counterSlice,
] // More slice add here
let store = slices->RTK.Store.configureStore
