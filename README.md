# mlx
An experimental dialect of OCaml to support JSX calling conventions.

This is *unusable alpha software*, so install at your own risk.

```
; cat mlx_test/print.mlx --language ocaml
───────┬─────────────────────────────────────────────────────────────────────────
       │ File: mlx_test/print.mlx
───────┼─────────────────────────────────────────────────────────────────────────
   1   │ let hello_world ~message () =
   2   │   <div id="main">
   3   │     <span className="font-bold"> "hello" </span>
   4 ~ │     <span className="font-bold"> (message|>string) </span>
   5   │   </div>
   6   │
   7   │ let () =
   8 ~ │   let message = Sys.argv.(1) in
   9 ~ │   Mlx_htmx.to_string (<hello_world message=message />)
  10   │   |> print_string
───────┴─────────────────────────────────────────────────────────────────────────
; dune exec ./mlx_test/print.exe -- oh-camel | pup --color
<html>
 <head>
 </head>
 <body>
  <div id="main">
   <span classname="font-bold">
    hello
   </span>
   <span classname="font-bold">
    oh-camel
   </span>
  </div>
 </body>
</html>
```
