open Preact

@jsx.component
let make = () => {

  // TODO
  let state2 = Counter2Slice.useState()
  let dispatch2 = Counter2Slice.useDispatch()

  let state3 = Counter3Slice.useState()
  let dispatch3 = Counter3Slice.useDispatch()

  // let (state4, dispatch4) = Counter4Slice.use()
  let state4 = Counter4Slice.useState()
  let dispatch4 = Counter4Slice.useDispatch()

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"What is this about?"->string} </h1>
    <p>
      {string("This is a simple template for a Vite project using ReScript & Tailwind CSS.")}
    </p>
    <h2 className="text-2xl font-semibold mt-5"> {string("Fast Refresh Test1")} </h2>
    // Counter2
    <Button onClick={_ => {
      let {incrementByAmount} = Counter2Slice.actions
      Console.log(("xxxx", incrementByAmount))
      dispatch2(incrementByAmount(2))
    }}>
      {string(`count 2 is ${state2.value->Int.toString}`)}
    </Button>
    <br />
    <br />
    // Counter3
    <Button onClick={_ => {
      dispatch3(IncrementByAmount(3))
    }}>
      {string(`count 3 is ${state3.value3->Int.toString}`)}
    </Button>
    <br />
    <br />
    // Counter4
    // <Button onClick={_ => {
    //   dispatch4(IncrementByAmount(4))
    // }}>
    //   {string(`count 4 is ${state4.value4->Int.toString}`)}
    // </Button>
    
  </div>
}
