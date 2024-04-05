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

      # exec-once = hyprctl setcursor Afterglow-Cursours-Recolored-Dracula-Cyan 16;
      # exec-once = "swww init"; # & sleep 0.5 && exec wallpaper_random;

      settings = {
        general = {
          border_size = 3;
          gaps_in = 8;
          gaps_out = 8;
          "col.inactive_border" = "rgba(00725fff)";
          "col.active_border" = "rgba(00f4ccff) rgba(28fcd9ff) 45deg";
          resize_on_border = true;
        };

        input = {
          kb_layout = "jp, de";
          kb_options = "ctrl:nocaps";
        };

        "$mod" = "SUPER";
        bind = [
          "$mod, RETURN, exec, wezterm"
          "$mod, SPACE, exec, wofi"
          "$mod, P, exec, grimblast copy area"
          "$mod, Q, killactive,"

          # Functional keybinds
          ", XF86AudioMicMute,exec,pamixer --default-source -t"
          ", XF86MonBrightnessDown,exec,light -U 20"
          ", XF86MonBrightnessUp,exec,light -A 20"
          ", XF86AudioMute,exec,pamixer -t"
          ", XF86AudioLowerVolume,exec,pamixer -d 10"
          ", XF86AudioRaiseVolume,exec,pamixer -i 10"

          "$mod, C, exec, hyprctl switchxkblayout"

          # "$mod, mouse_down, workspace, e-1"
          "$mod, V, togglefloating,"

          # Switch workspaces with super + [0-9]
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move active window to a workspace with super + SHIFT + [0-9]
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          # Scroll through existing workspaces with mainMod + scroll
          "$mod, mouse_down, workspace, e-1"
          "$mod, mouse_up  , workspace, e+1"

          # to switch between windows in a floating workspace
          "$mod, Tab, cyclenext,"
          "$mod, Tab, bringactivetotop,"

          # Move focus with mainMod + arrow keys
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, J, movefocus, u"
          "$mod, K, movefocus, d"

          "$mod, left, swapwindow, l"
          "$mod, right, swapwindow, r"
          "$mod, up, swapwindow, u"
          "$mod, down, swapwindow, d"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
        ];

        decoration = {
          rounding = 5;
          active_opacity = 1.0;
          inactive_opacity = 0.8;
          fullscreen_opacity = 1.0;
          drop_shadow = true;
          shadow_range = 4;

          "col.shadow" = "rgba(000000f0)";
          shadow_offset = "0 5";
          blur = {
            special = true;
            popups = true;
          };
        };
      };
    };
  };
}
