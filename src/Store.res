let slices = [Counter2Slice.counterSlice, Counter3Slice.counterSlice] // More slice add here
let store = slices->RTK.Store.configureStore
