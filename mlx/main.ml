let () =
  match Mlx.from_in_channel stdin with
  | Error _ ->
      exit 1
  | Ok ast -> Mlx.pp Format.std_formatter ast
