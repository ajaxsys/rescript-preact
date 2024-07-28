// Define Rs types
type state = {
  value: int
}

type action<'state> = {
  increment: (state) => state, // Can draft in js, so JS can update it & NO need to return anything
  decrement: (state) => state, // Can draft in js, so JS can update it & NO need to return anything
  incrementByAmount: (state, int) => state, // Can draft in js, so JS can update it & NO need to return anything
}

type slice<'state> = {
  name: string,
  initialState: 'state,
  reducers: action<'state>,
  reducer?: RTK.Redux.reducer<'state, 'state>
}

// Define init states
let emptyState = {
  value: 1
}

let initSlice: slice<state> = {
  name: "counter",
  initialState: emptyState,
  reducers: {
    increment: (state) => {value: state.value + 1},
    decrement: (state) => {value: state.value - 1},
    incrementByAmount: (state, amount) => {value: state.value + amount},
  },
}

let counterSlice = RTK.createSlice(initSlice)


// For export
// type action<'a> = {
//   increment: (int, 'a) => int,
//   decrement: (int, 'a) => int,
// }
let actions: action<state> = counterSlice->RTK.toActions

let useState: unit => state = () => counterSlice->RTK.toState

let dispatchExec: (RTK.useDispatchReturnType<unit>, state => state) => unit = %raw(`
  (dispatch, action) => {
    return dispatch(action());
  }
`)

let useActions = () => {
  let dispatch = RTK.useDispatch();

  let incrementCounter = () => {
    dispatchExec(dispatch, actions.increment);
  };

  let decrementCounter = () => {
    dispatchExec(dispatch, actions.decrement);
  };

  // TODO Need a new way
  // let incrementByAmountHandler = (amount) => {
  //   dispatchExec(dispatch, actions.incrementByAmount(amount));
  // }

  { "incrementCounter": incrementCounter, "decrementCounter":decrementCounter };
};
