let string s = s

let div () = "<div />"

let hr ?id:_ ?on_click:_ () = "<hr />"

let a ?id:_ ?(children=[]) () = 
  ignore children;
  "<a />"

let span ?(children=[]) () =
  ignore children;
  "<span />"

