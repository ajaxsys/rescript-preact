
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
      replaceReducer: reducer<'state, 'action> => unit
  }
}

// external convertToReducer: option<JSON.t> => Redux.reducer<'state, 'action> = "%identity"

module Provider = {
    type props<'children,'state,'action> = {key?: string, children: 'children, store: Redux.store<'state,'action>}

    @obj
    external
    makeProps: (~store: Redux.store<'state, 'action>, ~children: Jsx.element, ~key: 'key=?, unit)
        => {"children": Jsx.element, "store": Redux.store<'state, 'action>} = ""
        
    @module("react-redux")
    external provider: Jsx.component<props<'children,'state,'action>> = "Provider"

    let make: Jsx.component<props<'children,'state,'action>> = provider
}
