(lang dune 3.10)

(using menhir 2.1)
(cram enable)

(name mlx)

(generate_opam_files true)

(source
 (github leostera/mlx))

(authors "Leandro Ostera <leandro@abstractmachines.dev>")

(maintainers "Leandro Ostera <leandro@abstractmachines.dev>")

(license "MIT")

(package
 (name mlx)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
  (ocaml (>= "5.0.0"))
  (compiler-libs (>= "5.0.0"))
  (dune (>= "3.10.0"))
  (menhir (>= "20230608"))
 ))

(package
 (name mlx_test)
 (allow_empty)
 (depends
  (ocaml (>= "5.0.0"))
  (dune (>= "3.10.0"))
  (mlx :version)))

(dialect
 (name mlx)
 (implementation
  (extension mlx)
  (format (run mlx %{input-file})))
 (interface
  (extension mlxi)
  (format (run mlx %{input-file}))))
