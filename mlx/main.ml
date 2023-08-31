let () =
  match Mlx.from_in_channel stdin with
  | Ok ast -> Mlx.pp Format.std_formatter ast
  | Error _ -> exit 1
