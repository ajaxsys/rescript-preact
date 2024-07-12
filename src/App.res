@jsx.component
let make = () => {
  let (count, setCount) = Preact.useState(() => 0)

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"What is this about?"->Preact.string} </h1>
    <p>
      {Preact.string("This is a simple template for a Vite project using ReScript & Tailwind CSS.")}
    </p>
    <h2 className="text-2xl font-semibold mt-5"> {Preact.string("Fast Refresh Test")} </h2>
    <Button onClick={_ => setCount(count => count + 1)}>
      {Preact.string(`count xx is ${count->Int.toString}`)}
    </Button>
    <p>
      {Preact.string("Edit ")}
      <code> {Preact.string("src/App.res")} </code>
      {Preact.string(" and save to test Fast Refresh.")}
    </p>
  </div>
}
