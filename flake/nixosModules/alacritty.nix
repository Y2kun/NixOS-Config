{
  flake.nixosModules.alacritty = {
    config,
    lib,
    pkgs,
    ...
  }: {
    programs.alacritty = {
      # enable = true;
      settings = {
        # general = {
        #   shell.program = "fish";
        # };
        scrolling = {
          history = 100000;
          multiplier = 5;
        };
      };
    };
  };
}
