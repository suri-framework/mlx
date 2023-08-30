```
let%component button ~lola = <div> "Hola " ^ lola </div>

module Greeting = struct
  let make () = <button lola="Hello!" />
end
```

---

# Transform to this
```
module Greeting = struct
  let make () = button ~lola:"Hello!" ()
end
```

---

```
let greeting () = <Button lola="Hello!" />
```

---

# Automake

```
module Greeting = struct
  let make () = <button lola="Hello!" />
end

<Greeting>
```

---

# Props

```
let%component button ~lola = <div id="123" onClick=(fun event -> Js.log event)> "Hola " ^ lola </div>
```

---

# Children

```
let%component button = <div> ("Hola") </div>
```

---

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

---

# Self closing tag

```
let is_self_closing_tag = function
  (* https://github.com/facebook/react/blob/97d75c9c8bcddb0daed1ed062101c7f5e9b825f4/packages/react-dom-bindings/src/shared/omittedCloseTags.js *)
  | "area" | "base" | "br" | "col" | "embed" | "hr" | "img" | "input" | "link"
  | "meta" | "param" | "source" | "track" | "wbr" (* | "menuitem" *) ->
      true
  | _ -> false
```

---

# Library (HTMLFUNCTOR)

```
dune
    -open HTMLFUNCTOR

module HTMLFUNCTOR (T: I) = struct
  let common_attr = ~radioGroup ~role
  let div common_attr = T.div
end

module ReactDOM = HTMLFUNCTOR(ReactDOM.div = createElement,
module Tyxml = HTMLFUNCTOR(tyxml.div...)
```
