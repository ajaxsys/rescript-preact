open Preact

@jsx.component
let make = () => {

  // TODO
  let count2State = Counter2Slice.useState()
  let dispatch = RTK.useDispatch()

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"What is this about?"->string} </h1>
    <p>
      {string("This is a simple template for a Vite project using ReScript & Tailwind CSS.")}
    </p>
    <h2 className="text-2xl font-semibold mt-5"> {string("Fast Refresh Test")} </h2>
    // Counter2
    <Button onClick={_ => {
      let {incrementByAmount} = Counter2Slice.actions
      Console.log(("xxxx", incrementByAmount))
      dispatch(incrementByAmount(2))
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
