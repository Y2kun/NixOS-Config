{
  flake.nixosModules.waybar = {
    config,
    lib,
    pkgs,
    ...
  }: {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      style = ''
        * {
          background: transparent;
          font-family: Fira;
          font-size: 14px;
          padding: 1px;
        }

        window#waybar {
          background: rgba(0, 0, 0, 0.55);
        }

        #language, #temperature, #battery, #tray, #wireplumber, #disk, #cpu, #memory, #clock, #network {
          background: transparent;
          color: white;
          background: rgba(0, 0, 0, 0.5);
          border-radius: 25%;
          border: 2px solid rgba(0, 170, 170, 0.3);
        }

        #workspaces button {
          color: #fff;
          background: rgba(0, 0, 0, 0.5);
          border-radius: 45%;
          border: 2px solid rgba(255, 255, 255, 0.3);
          padding-left: 5px;
          padding-right: 5px;
        }

        #workspaces button.active {
          background: rgba(0, 170, 170, 0.7);
        }

        #workspaces button:hover {
          background: rgba(0, 200, 200, 0.8);
        }
      '';
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          # height = ;
          # width = ;
          # margin = "5";
          margin-top = 0;
          # "margin-<top|left|bottom|right>" = 5;
          spacing = 10;
          mode = "dock";
          reload_style_on_change = true;

          modules-left = [
            # "hyprland/mode"
            "backlight"
            "hyprland/language"
          ];

          modules-center = [
            "hyprland/workspaces"
          ];

          modules-right = [
            "tray"
            "wireplumber"
            "disk"
            "cpu"
            "memory"
            "temperature"
            # "network"
            "battery"
            "clock"
            # "keyboard-state"
            # "backlight"
          ];

          backlight = {
            device = "intel_backlight";
            format = "{percent}% {icon}";
            format-icons = ["" ""];
          };

          tray = {
            show-passive-items = true;
          };

          wireplumber = {
            format = "{icon} {volume:2}%";
            format-bluetooth = "{icon} {volume}%";
            format-muted = "MUTE";
            format-icons = {
              headphones = "";
              handsfree = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["🔈" "🔉" "🔊"];
            };
            on-click-left = "exec pavucontrol";
          };

          disk = {
            format = " {}%";
            tooltip-format = "{used} / {total} used";
          };

          cpu = {
            format = " {usage}%";
          };

          memory = {
            format = " {}%";
            tooltip-format = "{used:0.1f}G / {total:0.1f}G used";
          };

          temperature = {
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-icons = ["" "" "" "" ""];
          };

          "network#disconnected" = {
            tooltip-format = "No connection!";
            format-ethernet = "";
            format-wifi = "";
            format-linked = "";
            format-disconnected = "";
            on-click = "nm-connection-editor";
          };

          "network#ethernet" = {
            interface = "enp*";
            format-ethernet = "";
            format-wifi = "";
            format-linked = "";
            format-disconnected = "";
            tooltip-format = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-connection-editor";
          };

          "network#wifi" = {
            interface = "wlp*";
            format-ethernet = "";
            format-wifi = " {essid} ({signalStrength}%)";
            format-linked = "";
            format-disconnected = "";
            tooltip-format = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-connection-editor";
          };

          "network#vpn" = {
            interface = "tun0";
            format = "";
            format-disconnected = "";
            tooltip-format = "{ifname}: {ipaddr}/{cidr}";
            on-click = "nm-connection-editor";
          };

          battery = {
            format = "{icon} {capacity}%";
            format-alt = "{time} {icon}";
            tooltip-format = "{power}";
            format-icons = ["" "" "" "" ""];
            # format-charging = " {capacity}%";
            format-plugged = " { capacity}%";
            interval = 5;
            states = {
              warning = 20;
              critical = 10;
            };

            # format-discharging = "{capacity}% {icon}";
            # format-charging = "{capacity}% {icon}";
            # format-plugged = "{icon} {capacity}%";
            # format-icons = {
            #   default = ["" "" "" "" "" "" "" "" "" ""];
            #   charging = ["" "" "" "" "" "" "" ""];
            #   plugged = "ﮣ";
            # };
          };

          clock = {
            format = "{:%a %d %b %H:%M}";
            # tooltip-format = "{}";
          };

          "hyprland/language" = {
            format-jp = "Japanese";
            format-de = "German";
          };

          # "hyprland/workspaces" = {
          #   format = "{icons}";
          #   format-icons = {
          #     default = "0";
          #     active = "1";
          #     critical = "8";
          #   };
          # };
        };
      };
    };
  };
}
