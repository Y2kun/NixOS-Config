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
        general = {
          border_size = 3;
          gaps_in = 8;
          gaps_out = 8;
          # "col.inactive_border" = "rgba(00725fff)";
          # "col.active_border" = "rgba(00f4ccff) rgba(28fcd9ff) 45deg";
          resize_on_border = true;
        };

        input = {
          kb_layout = "jp, de, us";
          kb_options = "ctrl:nocaps, grp:alt_shift_toggle";
          kb_variant = "nodeadkeys";
          touchpad.disable_while_typing = false;
        };

        exec-once = [
          # "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
          # "hyprctl setcursor Afterglow-Cursours-Recolored-Dracula-Cyan 16"
          "swww-daemon"
          "systemctl --user restart waybar.service"
          "[workspace 1 silent] ${pkgs.firefox}/bin/firefox"
          "[workspace 2 silent] ${pkgs.wezterm}/bin/wezterm"
          "[workspace 9 silent] ${pkgs.xfce.thunar}/bin/thunar"
          # "[workspace 10 silent] ${pkgs.discord-canary}/bin/discordcanary"
        ];

        "$mod" = "SUPER";
        bind = [
          "$mod, RETURN, exec, wezterm"
          "$mod, SPACE, exec, wofi"
          "$mod, P, exec, grimblast copy area"
          "$mod, Q, killactive,"
          "$mod, L, exec, hyprlock"

          # Functional keybinds
          ", XF86MonBrightnessUp, exec, brightnessctl -q s +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl -q s 10%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          # ", XF86AudioMicMute, exec, wpctl set-source-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          # "$mod, C, exec, hyprctl switchxkblayout"

          # "$mod, mouse_down, workspace, e-1"
          "$mod, F, fullscreen"
          "$mod, V, togglefloating"
          "$mod, G, togglegroup"

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

        # workspace = [
        #   " 1, monitor:HDMI-A-1"
        #   " 2, monitor:HDMI-A-1"
        #   " 3, monitor:HDMI-A-1"
        #   " 4, monitor:HDMI-A-1"
        #   " 5, monitor:HDMI-A-1"
        #   " 6, monitor:HDMI-A-1"
        #   " 7, monitor:HDMI-A-1"
        #   " 8, monitor:HDMI-A-1"
        #   " 9, monitor:HDMI-A-1"
        #   "10, monitor:HDMI-A-1"
        #   "11, monitor:HDMI-A-2"
        #   "12, monitor:HDMI-A-2"
        #   "13, monitor:HDMI-A-2"
        #   "14, monitor:HDMI-A-2"
        #   "15, monitor:HDMI-A-2"
        #   "16, monitor:HDMI-A-2"
        #   "17, monitor:HDMI-A-2"
        #   "18, monitor:HDMI-A-2"
        #   "19, monitor:HDMI-A-2"
        #   "20, monitor:HDMI-A-2"
        #   "21, monitor:DP-1"
        #   "22, monitor:DP-1"
        #   "23, monitor:DP-1"
        #   "24, monitor:DP-1"
        #   "25, monitor:DP-1"
        #   "26, monitor:DP-1"
        #   "27, monitor:DP-1"
        #   "28, monitor:DP-1"
        #   "29, monitor:DP-1"
        #   "30, monitor:DP-1"
        # ];

        decoration = {
          rounding = 5;
          active_opacity = 1.0;
          inactive_opacity = 0.8;
          fullscreen_opacity = 1.0;
          drop_shadow = true;
          shadow_range = 4;

          # "col.shadow" = "rgba(000000f0)";
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
