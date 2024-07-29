open Preact

@jsx.component
let make = () => {

  let (state2, dispatch2) = Counter2Slice.use()
  let (state3, dispatch3) = Counter3Slice.use()
  let (state4, dispatch4) = Counter4Slice.use()
  // let state2 = Counter2Slice.useState()
  // let dispatch2 = Counter2Slice.useDispatch()

  // let state3 = Counter3Slice.useState()
  // let dispatch3 = Counter3Slice.useDispatch()

  // let state4 = Counter4Slice.useState()
  // let dispatch4 = Counter4Slice.useDispatch()

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"What is this about?"->string} </h1>
    <p>
      {"This is a simple template for a Vite project using ReScript & Tailwind CSS."->string}
    </p>
    <h2 className="text-2xl font-semibold mt-5"> {"Edit me to test Fast Refresh"->string} </h2>
    <hr />

    // Counter2
    <Button onClick={_ => {
      let {incrementByAmount} = Counter2Slice.actions
      // Console.log(("xxxx", incrementByAmount))
      dispatch2(incrementByAmount(2))
    }}>
      {`Count 2 is ${state2.value2->Int.toString}`->string}
    </Button>
    
    <br />
    <br />

    // Counter3
    <Button onClick={_ => {
      dispatch3(IncrementByAmount(3))
    }}>
      {`Count 3 is ${state3.value3->Int.toString}`->string}
    </Button>
    
    <br />
    <br />

    // Counter4
    <Button onClick={_ => {
      dispatch4(IncrementByAmount(4))
    }}>
      {`Count 4 is ${state4.value4->Int.toString}`->string}
    </Button>
    <br />
    <br />
  </div>
}
