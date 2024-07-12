// Preact.res
/* Below is a number of aliases to the common `Jsx` module */
type element = Jsx.element

type component<'props> = Jsx.component<'props>

type componentLike<'props, 'return> = Jsx.componentLike<'props, 'return>
@module("preact")
external render: (Jsx.element, Dom.element) => unit = "render"

@module("preact/jsx-runtime")
external jsx: (component<'props>, 'props) => element = "jsx"

@module("preact/jsx-runtime")
external jsxKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsx"

@module("preact/jsx-runtime")
external jsxs: (component<'props>, 'props) => element = "jsxs"

@module("preact/jsx-runtime")
external jsxsKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsxs"

/* These identity functions and static values below are optional, but lets 
you move things easily to the `element` type. The only required thing to 
define though is `array`, which the JSX transform will output. */
external array: array<element> => element = "%identity"
@val external null: element = "null"

external float: float => element = "%identity"
external int: int => element = "%identity"
external string: string => element = "%identity"

/* These are needed for Fragment (<> </>) support */
type fragmentProps = {children?: element}

@module("preact/jsx-runtime") external jsxFragment: component<fragmentProps> = "Fragment"

/* The Elements module is the equivalent to the ReactDOM module in React. This holds things relevant to _lowercase_ JSX elements. */
module Elements = {
  /* Here you can control what props lowercase JSX elements should have. 
  A base that the React JSX transform uses is provided via JsxDOM.domProps, 
  but you can make this anything. The editor tooling will support 
  autocompletion etc for your specific type. */
  type props = JsxDOM.domProps

  @module("preact/jsx-runtime")
  external jsx: (string, props) => Jsx.element = "jsx"

  @module("preact/jsx-runtime")
  external div: (string, props) => Jsx.element = "jsx"

  @module("preact/jsx-runtime")
  external jsxKeyed: (string, props, ~key: string=?, @ignore unit) => Jsx.element = "jsx"

  @module("preact/jsx-runtime")
  external jsxs: (string, props) => Jsx.element = "jsxs"

  @module("preact/jsx-runtime")
  external jsxsKeyed: (string, props, ~key: string=?, @ignore unit) => Jsx.element = "jsxs"

  external someElement: element => option<element> = "%identity"
}

// @module("preact/hooks")
// external render: (element, Dom.element) => unit = "render"

/* HOOKS */

/*
 * Yeah, we know this api isn't great. tl;dr: useReducer instead.
 * It's because useState can take functions or non-function values and treats
 * them differently. Lazy initializer + callback which returns state is the
 * only way to safely have any type of state and be able to update it correctly.
 */
@module("preact/hooks")
external useState: (@uncurry (unit => 'state)) => ('state, ('state => 'state) => unit) = "useState"

@module("preact/hooks")
external useReducer: (@uncurry ('state, 'action) => 'state, 'state) => ('state, 'action => unit) =
  "useReducer"

@module("preact/hooks")
external useReducerWithMapState: (
  @uncurry ('state, 'action) => 'state,
  'initialState,
  @uncurry ('initialState => 'state),
) => ('state, 'action => unit) = "useReducer"

@module("preact/hooks")
external useEffectOnEveryRender: (@uncurry (unit => option<unit => unit>)) => unit = "useEffect"
@module("preact/hooks")
external useEffect: (@uncurry (unit => option<unit => unit>), 'deps) => unit = "useEffect"
@module("preact/hooks")
external useEffect0: (@uncurry (unit => option<unit => unit>), @as(json`[]`) _) => unit =
  "useEffect"
@module("preact/hooks")
external useEffect1: (@uncurry (unit => option<unit => unit>), array<'a>) => unit = "useEffect"
@module("preact/hooks")
external useEffect2: (@uncurry (unit => option<unit => unit>), ('a, 'b)) => unit = "useEffect"
@module("preact/hooks")
external useEffect3: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c)) => unit = "useEffect"
@module("preact/hooks")
external useEffect4: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd)) => unit =
  "useEffect"
@module("preact/hooks")
external useEffect5: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd, 'e)) => unit =
  "useEffect"
@module("preact/hooks")
external useEffect6: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd, 'e, 'f)) => unit =
  "useEffect"
@module("preact/hooks")
external useEffect7: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useEffect"

@module("preact/hooks")
external useLayoutEffectOnEveryRender: (@uncurry (unit => option<unit => unit>)) => unit =
  "useLayoutEffect"
@module("preact/hooks")
external useLayoutEffect: (@uncurry (unit => option<unit => unit>), 'deps) => unit =
  "useLayoutEffect"
@module("preact/hooks")
external useLayoutEffect0: (@uncurry (unit => option<unit => unit>), @as(json`[]`) _) => unit =
  "useLayoutEffect"
@module("preact/hooks")
external useLayoutEffect1: (@uncurry (unit => option<unit => unit>), array<'a>) => unit =
  "useLayoutEffect"
@module("preact/hooks")
external useLayoutEffect2: (@uncurry (unit => option<unit => unit>), ('a, 'b)) => unit =
  "useLayoutEffect"
@module("preact/hooks")
external useLayoutEffect3: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c)) => unit =
  "useLayoutEffect"
@module("preact/hooks")
external useLayoutEffect4: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd)) => unit =
  "useLayoutEffect"
@module("preact/hooks")
external useLayoutEffect5: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd, 'e)) => unit =
  "useLayoutEffect"
@module("preact/hooks")
external useLayoutEffect6: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f),
) => unit = "useLayoutEffect"
@module("preact/hooks")
external useLayoutEffect7: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useLayoutEffect"

@module("preact/hooks")
external useMemo: (@uncurry (unit => 'any), 'deps) => 'any = "useMemo"

@module("preact/hooks")
external useMemo0: (@uncurry (unit => 'any), @as(json`[]`) _) => 'any = "useMemo"

@module("preact/hooks")
external useMemo1: (@uncurry (unit => 'any), array<'a>) => 'any = "useMemo"

@module("preact/hooks")
external useMemo2: (@uncurry (unit => 'any), ('a, 'b)) => 'any = "useMemo"

@module("preact/hooks")
external useMemo3: (@uncurry (unit => 'any), ('a, 'b, 'c)) => 'any = "useMemo"

@module("preact/hooks")
external useMemo4: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd)) => 'any = "useMemo"

@module("preact/hooks")
external useMemo5: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd, 'e)) => 'any = "useMemo"

@module("preact/hooks")
external useMemo6: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f)) => 'any = "useMemo"

@module("preact/hooks")
external useMemo7: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'any = "useMemo"

@module("preact/hooks")
external useCallback: ('f, 'deps) => 'f = "useCallback"

@module("preact/hooks")
external useCallback0: ('f, @as(json`[]`) _) => 'f = "useCallback"

@module("preact/hooks")
external useCallback1: ('f, array<'a>) => 'f = "useCallback"

@module("preact/hooks")
external useCallback2: ('f, ('a, 'b)) => 'f = "useCallback"

@module("preact/hooks")
external useCallback3: ('f, ('a, 'b, 'c)) => 'f = "useCallback"

@module("preact/hooks")
external useCallback4: ('f, ('a, 'b, 'c, 'd)) => 'f = "useCallback"

@module("preact/hooks")
external useCallback5: ('f, ('a, 'b, 'c, 'd, 'e)) => 'f = "useCallback"

@module("preact/hooks")
external useCallback6: ('callback, ('a, 'b, 'c, 'd, 'e, 'f)) => 'callback = "useCallback"

@module("preact/hooks")
external useCallback7: ('callback, ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'callback = "useCallback"

// @module("preact/hooks")
// external useContext: Context.t<'any> => 'any = "useContext"

@module("preact/hooks") external useRef: 'value => ref<'value> = "useRef"
