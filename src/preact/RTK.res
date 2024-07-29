type useDispatchReturnType<'action> = 'action => unit

%%private(
  
  @module("react-redux")
  external useSelector_: (@uncurry 'state => 'subState) => 'subState = "useSelector"

  @module("react-redux")
  external useDispatch_: unit => useDispatchReturnType<'action> = "useDispatch"
)

let useSelector: (@uncurry 'state => 'subState) => 'subState = useSelector_
let useDispatch: unit => useDispatchReturnType<'action> = useDispatch_

%%private(
  let actionAdaptor: ('slice, 'actionParam) => 'action = %raw(`
    (slice, actionNameMayStringOrObject) => {
      const isWithParam = actionNameMayStringOrObject["TAG"]
      const actionName = isWithParam ? actionNameMayStringOrObject["TAG"] : actionNameMayStringOrObject
      const actionFn = slice["actions"][actionName]
      // console.debug("Called actionAdaptor", slice, actionName, actionFn)
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
)
let useDispatchOf: ('slice, array<'action>) => useDispatchReturnType<'action> = (slice, _) => {
  let dispatch = useDispatch()
  (a) => {
    dispatch(slice->actionAdaptor(a))
  }
}

%%private(
  let stateAdaptor: 'slice => 'state = %raw(`
    slice => {
      return useSelector((state) => {
        const stateOfSlice = state[slice.name]
        if (stateOfSlice) {
          return stateOfSlice
        }
        console.debug("Current state", state)
        throw new Error("Fatal! Did you forgot add slice \'" + slice.name + "\' to store?")
      });
    }
  `)
)

let useStateOf: ('slice, 'state) => 'state = (slice, _state) => stateAdaptor(slice)

let toActions: 'slice => 'actions = %raw(`slice => slice["actions"]`)

type sliceTypeActions
type sliceTypeReducer

// TODO more type
type sliceType<'state> = {
  name: string,
  initialState: 'state,
  actions: sliceTypeActions,
  reducer: sliceTypeReducer,
}
// type sliceType = {
//   name: string,
// }


@module("@reduxjs/toolkit")
external createSlice: 'sliceConfig => sliceType<'state> = "createSlice"

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
let createSliceWithActionArray = (
  name: string,
  initialState: 'state,
  (reducer, reducerActions: array<'ra>)
): sliceType<'state> => {
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
let createSliceWithActionMapping = (
  name: string,
  initialState: 'state,
  (reducer, reducerActions)
): sliceType<'state> => {
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
    let createReducers: 'slices => JSON.t = %raw(` // sliceType<'state> | array<sliceType<'state>>
      (singleReducerOrArray) => {
        const reducers = Array.isArray(singleReducerOrArray) ? singleReducerOrArray : [singleReducerOrArray]
        console.log("Tuble", reducers, typeof reducers);
        const r = {}
        reducers.forEach(reducer => {
            if (reducer && reducer.name) {
            r[reducer.name] = reducer["reducer"]
            }
        });
        return r;
      }
    `)
  )

  let configureStore = (slices: 'sliceTypeOrTuples) => {
    configureStore_({
      reducer: createReducers(slices),
    })
  }
}
