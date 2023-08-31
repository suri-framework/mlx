let from_src ~src =
  let buf = Lexing.from_string src in
  match Parser.use_file Lexer.token buf with
  | exception e ->
      Printf.eprintf "Found an error in line:\n%s"
        (Bytes.to_string buf.lex_buffer);
      Printf.eprintf "%*s %s" buf.lex_curr_pos "^" (Printexc.to_string e);
      Error e
  | ast -> Ok ast

let from_in_channel ch =
  let src = In_channel.input_all ch in
  from_src ~src

let pp fmt phrases =
  Printf.printf "(* generated with mlx: do not edit! *)";
  Format.pp_force_newline fmt ();
  List.iter (Pprintast.top_phrase fmt) phrases;
  Format.pp_force_newline fmt ()
