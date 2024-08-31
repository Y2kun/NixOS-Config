{
  inputs,
  config,
  # lib,
  ...
}: let
  mkHost = name: {
    deployment.targetHost = name;
    deployment.allowLocalDeployment = true;
    imports = [
      inputs.home-manager.nixosModules.home-manager
      config.flake.nixosModules.common
      config.flake.nixosModules.${name}
    ];
  };
in {
  flake.colmena = {
    meta.nixpkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    # meta.specialArgs = { inherit inputs; };

    kappa = mkHost "kappa";
    lambda = mkHost "lambda";
  };
}
