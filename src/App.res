open Preact

@jsx.component
let make = () => {

  let countState = CounterSlice.useState()
  let actions = CounterSlice.useActions()

  // TODO
  let count2State = Counter2Slice.useState()
  let dispatch = RTK.useDispatch2()


  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"What is this about?"->string} </h1>
    <p>
      {string("This is a simple template for a Vite project using ReScript & Tailwind CSS.")}
    </p>
    <h2 className="text-2xl font-semibold mt-5"> {string("Fast Refresh Test")} </h2>
    <Button onClick={_ => actions["incrementCounter"]()}>
      {string(`count is ${countState.value->Int.toString}`)}
    </Button>
    <br />
    <br />
    // Counter2
    <Button onClick={_ => {
      let a = RTK.action(Counter2Slice.counterSlice, Counter2Slice.IncrementByAmount(2))
      Console.log(("xxxx", a))
      dispatch(a)
    }}>
      {string(`count2 is ${count2State.value->Int.toString}`)}
    </Button>
    <p>
      {string("Edit ")}
      <code> {string("src/App.res")} </code>
      {string(" and save to test Fast Refresh.")}
    </p>
  </div>
}
