type useDispatchReturnType<'action> = 'action => unit

%%private(
  
  @module("react-redux")
  external useSelector_: (@uncurry 'state => 'subState) => 'subState = "useSelector"

  @module("react-redux")
  external useDispatch_: unit => useDispatchReturnType<'action> = "useDispatch"
)

let useSelector: (@uncurry 'state => 'subState) => 'subState = useSelector_
let useDispatch: unit => useDispatchReturnType<'action> = useDispatch_


// TODO
let action: ('slice, 'actionParam) => 'action = %raw(`
  (slice, actionNameMayStringOrObject) => {
    const isWithParam = actionNameMayStringOrObject["TAG"]
    const actionName = isWithParam ? actionNameMayStringOrObject["TAG"] : actionNameMayStringOrObject
    const actionFn = slice["actions"][actionName]
    console.log(slice, actionName, actionFn)
    if (!actionFn) {
      throw new Error("Action not exist, " + actionName);
    }
    if (isWithParam) {
      return actionFn(actionNameMayStringOrObject)
    } else {
      return actionFn()
    }
  }
`)

let toState: 'slice => 'state = %raw(`
  slice => {
    return useSelector((state) => {
      return state[slice.name]
    });
  }
`)

let toActions: 'slice => 'actions = %raw(`slice => slice["actions"]`)

// TODO more type
// type sliceType<'state> = {
//   name: string,
//   initialState: 'state,
// }
type sliceType = {
  name: string,
}


@module("@reduxjs/toolkit")
external createSlice: 'slice => sliceType = "createSlice"

%%private(
  let toReducersObject = %raw(`
    (reducer, reducerActions) => {
      const actionNames = reducerActions.map(ra => ra["TAG"] ? ra["TAG"] : ra)
      const result = actionNames.reduce((obj, actionName) => {
        obj[actionName] = (s, a) => {
          // console.log("A wrapper to extract payload from Redux toolkit")
          // which like '{"type":"counter2/IncrementByAmount","payload":{"TAG":"IncrementByAmount","_0":2}}'
          return reducer(s, a["payload"]);
        }
        return obj;
      }, {});
      return result
    }
  `)
)

// TODO
let createSlice2 = (name: string, initialState: 'state, (reducer, reducerActions: array<'ra>)) => {
  createSlice({
    "name": name,
    "initialState": initialState,
    "reducers": toReducersObject(reducer, reducerActions)
  })
}



%%private(
  let appendReducer = %raw(`
    (reducerActions, reducer) => {
      const result = Object.fromEntries(
        // fn return a "type action" like IncrementByAmount(int)
        Object.entries(reducerActions).map(([key, actionFn]) => [key, (s, actionMayWithPayLoad) => {
          const actionCombined = actionMayWithPayLoad["payload"] ? actionFn(actionMayWithPayLoad["payload"]) : actionFn()
          // console.log("combind type action and real payload", actionCombined)
          return reducer(s, actionCombined)
        }])
      );
      return result
    }
  `)
)
let createSlice3 = (name: string, initialState: 'state, (reducer, reducerActions)): sliceType => {
  createSlice({
    "name": name,
    "initialState": initialState,
    "reducers": appendReducer(reducerActions, reducer)
  })
}

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
    let createReducers: 'slices => JSON.t = %raw(` // array<sliceType<'state>>
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

  let configureStore = (slices: array<sliceType>) => {
    configureStore_({
      reducer: createReducers(slices),
    })
  }
}
