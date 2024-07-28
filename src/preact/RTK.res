@module("react-redux")
external useSelector_: (@uncurry 'state => 'subState) => 'subState = "useSelector"
let useSelector: (@uncurry 'state => 'subState) => 'subState = useSelector_

type useDispatchReturnType<'action> = 'action => unit

@module("react-redux")
external useDispatch_: unit => useDispatchReturnType<'action> = "useDispatch"
let useDispatch: unit => useDispatchReturnType<'action> = useDispatch_

let toState: 'slice => 'state = %raw(`
  slice => {
    return useSelector((state) => {
      return state[slice.name]
    });
  }
`)

let toActions: 'slice => 'actions = %raw(`slice => slice["actions"]`)

@module("@reduxjs/toolkit")
external createSlice: 'slice => Js.Dict.t<JSON.t> = "createSlice"

module Redux = {
  type reducer<'state, 'action> = ('state, 'action) => 'state

  type preloadedState<'state> = 'state

  type storeSubscribeListener = unit => unit

  type subscribeCallback = unit => unit

  type unsubscribe = unit => unit

  type store<'state, 'action> = {
    getState: unit => 'state,
    dispatch: 'action => unit, // Do NOT use directly, miss "type" in RS
    subscribe: subscribeCallback => unsubscribe,
    replaceReducer: reducer<'state, 'action> => unit,
  }
}

module Provider = {
  type props<'children, 'state, 'action> = {
    key?: string,
    children: 'children,
    store: Redux.store<'state, 'action>,
  }

  @obj
  external makeProps: (
    ~store: Redux.store<'state, 'action>,
    ~children: Jsx.element,
    ~key: 'key=?,
    unit,
  ) => {"children": Jsx.element, "store": Redux.store<'state, 'action>} = ""

  @module("react-redux")
  external provider: Jsx.component<props<'children, 'state, 'action>> = "Provider"

  let make: Jsx.component<props<'children, 'state, 'action>> = provider
}

module Store = {
  type configureStoreType = {reducer: JSON.t}

  type allState
  type allAction

  @module("@reduxjs/toolkit")
  external configureStore_: configureStoreType => Redux.store<allState, allAction> =
    "configureStore"

  %%private(
    let createReducers: array<Js.Dict.t<RescriptCore.JSON.t>> => JSON.t = %raw(`
            (reducers) => {
            const r = {}
            reducers.forEach(reducer => {
                if (reducer && reducer.name) {
                r[reducer.name] = reducer["reducer"]
                }
            });
            return r;
        }`)
  )

  let configureStore = (slices: array<Js.Dict.t<RescriptCore.JSON.t>>) => {
    configureStore_({
      reducer: createReducers(slices),
    })
  }
}
