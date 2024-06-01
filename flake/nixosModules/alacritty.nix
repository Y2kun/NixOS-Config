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
        window = {
          opacity = 0.9;
        };

        scrolling = {
          history = 100000;
          multiplier = 5;
        };

        font = {
          normal = {
            family = "Fira Code";
            style = "Regular";
          };

          size = 14;
        };

        colors = {
          primary = {
            foreground = "#dddddd";
            background = "#0f0f0f";
          };

          cursor = {
            text = "#00ffaa";
            cursor = "#00aa11";
          };
        };
      };
    };
  };
}
