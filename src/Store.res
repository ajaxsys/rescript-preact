let slices = [CounterSlice.counterSlice, Counter2Slice.counterSlice] // More slice add here
let store = slices->RTK.Store.configureStore
