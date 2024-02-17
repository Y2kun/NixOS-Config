flake: {
  perSystem = {
    lib,
    pkgs,
    config,
    inputs',
    self',
    ...
  }: {
    devShells.default = let
      inherit (flake.config.flake) cluster;
    in
      pkgs.mkShell {
        packages = with pkgs; [
          deadnix
          inputs'.colmena.packages.colmena
          just
          statix
          config.treefmt.build.wrapper
        ];

        shellHook = ''
          ln -sf ${config.treefmt.build.configFile} treefmt.toml
        '';
      };
  };
}
