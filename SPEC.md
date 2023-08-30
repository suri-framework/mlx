OCaml with JSX (mlx, because xml is already taken)

- Transform .mlx into .ml
- Provide a HTMLFUNCTOR to create libs on top of JSX
  - react.mlx should call HTMLFUNCTOR with custom bindings like React.createElement, and other React specific stuff
  - tyxml.mlx should call HTMLFUNCTOR with tyxml html lib
  - revery.mlx should call HTMLFUNCTOR with revery html lib
    - htmx.mlx will use tyxml-mlx to define a interface for htmx

```
(* input.mlx *)
let%component button ~lola = <div> "Hola " ^ lola </div>

module Greeting = struct
  let make () = <button lola="Hello!" />
end
```

### transforms into this

```
(* output.ml *)
module Greeting = struct
  let make () = button ~lola:"Hello!" ()
end
```

That can be also a function

```
let greeting () = <Button lola="Hello!" />
```

# Automake

When a Uppercase module is found in JSX, asume make function

```
module Greeting = struct
  let make () = <button lola="Hello!" />
end

<Greeting>
```

# Props

Labelled props use `:propName '=' expr`

```
let%component button ~lola = <div id="123" onClick=(fun event -> Js.log event)> "Hola " ^ lola </div>
```

# Children

Children expressions are `()`

```
let%component button = <div> ("Hola") </div>
```

# Children type

```
<modal> <div> ("Hola") </div> </modal> // modal ~children:[div ~children:[T.string "Hola"]]
<modal> ([<div> ("Hola") </div>]) </modal> // modal ~children:(T.list [div ~children:[T.string "Hola"]])
<modal> (items->STD.list) </modal> // modal ~children:items

<modal>
  <div> ("Hola") </div>
  adios
</modal> // modal ~children:T.list [div ~children:[T.string "Hola"], adios]

<modal>
  ([<div> ("Hola") </div> ] :: adios)
</modal> // modal ~children:T.list (div ~children:[T.string "Hola"]) :: adios

<modal>
  <div> ("Hola") </div>
  ...adios
</modal> // modal ~children:T.list (div ~children:[T.string "Hola"]) :: adios
```

# Library (HTMLFUNCTOR)

```
dune
    -open HTMLFUNCTOR

module HTMLFUNCTOR (T: I) = struct
  let common_attr = ~radioGroup ~role
  let div common_attr = T.div
end

module ReactDOM = HTMLFUNCTOR({ div = createElement "div"; ul = createElement "ul"; li, etc...})
module Tyxml = HTMLFUNCTOR({ div = tyxml.div; etc... })
```

# Self closing tag

```
let is_self_closing_tag = function
  (* https://github.com/facebook/react/blob/97d75c9c8bcddb0daed1ed062101c7f5e9b825f4/packages/react-dom-bindings/src/shared/omittedCloseTags.js *)
  | "area" | "base" | "br" | "col" | "embed" | "hr" | "img" | "input" | "link"
  | "meta" | "param" | "source" | "track" | "wbr" (* | "menuitem" *) ->
      true
  | _ -> false
```
