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
          colmena
          statix
          config.treefmt.build.wrapper
          just
        ];

        shellHook = ''
          ln -sf ${config.treefmt.build.configFile} treefmt.toml
        '';
      };
  };
}
