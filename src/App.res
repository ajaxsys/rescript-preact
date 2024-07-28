open Preact

@jsx.component
let make = () => {

  let countState = CounterSlice.useState()
  let actions = CounterSlice.useActions()

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"What is this about?"->string} </h1>
    <p>
      {string("This is a simple template for a Vite project using ReScript & Tailwind CSS.")}
    </p>
    <h2 className="text-2xl font-semibold mt-5"> {string("Fast Refresh Test")} </h2>
    <Button onClick={_ => actions["incrementCounter"]()}>
      {string(`count is ${countState.value->Int.toString}`)}
    </Button>
    <p>
      {string("Edit ")}
      <code> {string("src/App.res")} </code>
      {string(" and save to test Fast Refresh.")}
    </p>
  </div>
}
