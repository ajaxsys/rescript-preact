%%raw("import './index.css'")
open Preact

switch Doc.querySelector("#root") {
| Some(domElement) =>
  render(
    <RTK.Provider store=Store.store>
      <App />
    </RTK.Provider>, domElement)
| None => ()
}
