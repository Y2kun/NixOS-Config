{
  flake.nixosModules.hyprland = {
    config,
    lib,
    pkgs,
    ...
  }: {
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
      systemd.enable = true;
      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, Enter, exec, wezterm"
          "$mod, Space, exec, wofi -show drun -show-icons"
          "$mod, P, exec, grimblast copy area"
          "$mod, mouse:272, movewindow"
        ];
        decoration = {
          shadow_offset = "0 5";
          "col.shadow" = "rgba(00000099)";
        };
      };
    };
  };
}
