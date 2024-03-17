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
          "$mod, RETURN, exec, wezterm"
          "$mod, Q, killactive"
          "$mod, SPACE, exec, wofi"
          "$mod, P, exec, grimblast copy area"
        ];
        bindm = [
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
