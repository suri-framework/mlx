Test the (dialect ...) stanza inside the dune-project file.

  $ cat self_closing.mlx | mlx
  $ cat open_and_close.mlx | mlx

Tag must be closed by same tag
  $ cat wrong_closing_tag.mlx | mlx
  Found an error in line:
  let _ = <spoon></span>
                        ^ Failure("Open and close tags don't match: 'spoon' and 'span'.  See line 1-1, characters 9-14")
