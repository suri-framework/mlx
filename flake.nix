{
  description = "Simple JSX support for OCaml";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          inherit (pkgs) ocamlPackages mkShell;
          inherit (ocamlPackages) buildDunePackage;
          version = "0.0.1";
        in
          {
            devShells = {
              default = mkShell {
                buildInputs = [ ocamlPackages.utop ];
                inputsFrom = [ self'.packages.default ];
              };
            };

            packages = {
              default = buildDunePackage {
                inherit version;
                pname = "mlx";
                nativeBuildInputs = with ocamlPackages; [ menhir ];
                propagatedBuildInputs = with ocamlPackages; [ ppxlib ];
                src = ./.;
              };
              mlx_htmx = buildDunePackage {
                inherit version;
                pname = "mlx_htmx";
                propagatedBuildInputs = with ocamlPackages; [
                  self'.packages.default
                  tyxml
                ];
                src = ./.;
              };
              mlx_test = buildDunePackage {
                inherit version;
                pname = "mlx_test";
                propagatedBuildInputs = [
                  self'.packages.default
                  self'.packages.mlx_htmx
                ];
                src = ./.;
              };
            };
          };
    };
}
