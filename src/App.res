open Preact

@module("react-redux")
external
useSelector_: (@uncurry 'state => 'subState) => 'subState = "useSelector"
let useSelector: (@uncurry 'state => 'subState) => 'subState = useSelector_

type useDispatchReturnType<'action> = 'action => unit

@module("react-redux")
external
useDispatch_: unit => useDispatchReturnType<'action> = "useDispatch"
let useDispatch: unit => useDispatchReturnType<'action> = useDispatch_

if (true) {
  Console.log2(useSelector, useDispatch)
}

let rtkSelector: Js.Dict.t<RescriptCore.JSON.t> => CounterSlice.state = %raw(`
  slice => {
    return useSelector((state) => {
      return state[slice.name]
    });
  }
`)
let rtkAction: Js.Dict.t<RescriptCore.JSON.t> => CounterSlice.action<CounterSlice.state> = %raw(`
  slice => {
    return slice.actions;
  }
`)

let dispatchExec: (useDispatchReturnType<unit>, CounterSlice.state => CounterSlice.state) => unit = %raw(`
  (dispatch, action) => {
    return dispatch(action());
  }
`)
let useCounterActions = () => {
  let countAction:CounterSlice.action<CounterSlice.state> = rtkAction(CounterSlice.counterSlice)
  let dispatch = useDispatch();

  let incrementCounter = () => {
    dispatchExec(dispatch, countAction.increment);
  };

  let decrementCounter = () => {
    dispatchExec(dispatch, countAction.decrement);
  };

  { "incrementCounter": incrementCounter, "decrementCounter":decrementCounter };
};


@jsx.component
let make = () => {
  // let (count, setCount) = useState(() => 0)

  // TODO how to use?
  // const count = useSelector((state) => state.counter.value);

  let count:CounterSlice.state = rtkSelector(CounterSlice.counterSlice)
  
  let x = useCounterActions()

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"What is this about?"->string} </h1>
    <p>
      {string("This is a simple template for a Vite project using ReScript & Tailwind CSS.")}
    </p>
    <h2 className="text-2xl font-semibold mt-5"> {string("Fast Refresh Test")} </h2>
    <Button onClick={_ => x["incrementCounter"]()}>
      {string(`count is ${count.value->Int.toString}`)}
    </Button>
    <p>
      {string("Edit ")}
      <code> {string("src/App.res")} </code>
      {string(" and save to test Fast Refresh.")}
    </p>
  </div>
}
