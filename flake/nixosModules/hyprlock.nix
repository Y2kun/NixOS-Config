{
  flake.nixosModules.hyprlock = {
    config,
    lib,
    pkgs,
    ...
  }: {
    programs.hyprlock = {
      enable = true;
      settings = {
        text_color = "rgba(F1F1F1FF)";
        entry_background_color = "rgba(13131311)";
        entry_border_color = "rgba(91919155)";
        entry_color = "rgba(C6C6C6FF)";
        font_family = "Fira";
        font_family_clock = "Fira";
        font_material_symbols = "Fira Code Symbols";

        general = {
          grace = 0.5;
        };

        background = {
          monitor = "";
          path = "/home/yuma/wallpaper/wallhaven-bastion.jpg";
          blur_size = 4;
          blur_passes = 4;
          # color = "rgba(13131377)";
          # path = screenshot;
        };

        # Profilepicture
        image = {
          monitor = "";
          path = "/home/yuma/wallpaper/Profilepicture/PFP.png";
          size = 250;
          rounding = 75;
          border_size = 4;
          border_color = "rgb(5, 16, 20)";
          position = "0, 125";
          halign = "center";
          valign = "center";
        };

        # input-field = {
        #   monitor = "";
        #   size = "250, 50";
        #   outline_thickness = 2;
        #   dots_size = 0.1;
        #   dots_spacing = 0.3;
        #   outer_color = "$entry_border_color";
        #   inner_color = "$entry_background_color";
        #   font_color = "$entry_color";
        #   # fade_on_empty = true

        #   position = "0, 20";
        #   halign = "center";
        #   valign = "center";
        # };

        input-field = {
          monitor = "";
          size = "300, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.1;
          dots_center = true;
          dots_rounding = -1;
          outer_color = "rgb(10, 20, 20)";
          inner_color = "rgb(0, 60, 60)";
          fade_on_empty = false;
          placeholder_text = "Insert $USER's Password";
          hide_input = false;
          rounding = 12;
          fail_color = "rgb(255, 123, 123)";
          fail_text = "You suck, try again";
          position = "0, -120";
          halign = "center";
          valign = "center";
        };

        label = [
          # {
          #   # Clock
          #   monitor = "";
          #   text = "$TIME";
          #   shadow_passes = 1;
          #   shadow_boost = 0.5;
          #   color = "$text_color";
          #   font_size = 65;
          #   font_family = "$font_family_clock";

          #   position = "0, 300";
          #   halign = "center";
          #   valign = "center";
          # }
          # {
          #   # Greeting
          #   monitor = "";
          #   text = "Greetings $USER";
          #   shadow_passes = 1;
          #   shadow_boost = 0.5;
          #   color = "$text_color";
          #   font_size = 24;
          #   font_family = "$font_family";

          #   position = "0, 240";
          #   halign = "center";
          #   valign = "center";
          # }
          {
            # "locked" text
            monitor = "";
            text = "This Device is currently locked";
            shadow_passes = 1;
            shadow_boost = 0.5;
            color = "$text_color";
            font_size = 14;
            font_family = "$font_family";

            position = "0, 50";
            halign = "center";
            valign = "bottom";
          }
          # { # lock icon
          #     monitor = "";
          #     text = "lock";
          #     shadow_passes = 1;
          #     shadow_boost = 0.5;
          #     color = "$text_color";
          #     font_size = 21;
          #     font_family = "$font_material_symbols";

          #     position = "0, 65";
          #     halign = "center";
          #     valign = "bottom";
          # }
        ];
      };
    };
  };
}
