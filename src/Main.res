%%raw("import './index.css'")
open Preact

switch Doc.querySelector("#root") {
| Some(domElement) =>
  render(<App />, domElement)
| None => ()
}
