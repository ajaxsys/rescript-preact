let slices = (
  Counter2Slice.slice, 
  Counter3Slice.slice,
  Counter4Slice.slice,
) // More slice add here
let store = slices->RTK.Store.configureStore
