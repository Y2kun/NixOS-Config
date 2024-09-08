{
  flake.nixosModules.wofi = {
    config,
    lib,
    pkgs,
    ...
  }: {
    programs.wofi = {
      enable = true;
      settings = {
        location = "center";
        layer = "overlay";
        term = "wezterm";
        mode = "drun";
        sort_order = "alphabetical";
        widht = "30%";
        lines = 10;
        line_wrap = "word";
        show_all = true;
        allow_images = true;
        image_size = 20;
        key_expand = "Tab";
        allow_markup = true;
        insensitive = true;
        gtk_dark = true;
      };

      style = ''
          * {
        #     font-family: JetBrainsMono;
        #     color: #e5e9f0;
            background: transparent;
          }

          #window {
        #     background: #111111;
            margin: auto;
            padding: 10x;
            border-radius: 5px;
        #     border: 3px solid #00f4cc;
        #   }

          #input {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 15px;
          }

          #outer-box {
            padding: 20px;
          }

          #img {
            margin-right: 6px;
          }

          #entry {
            padding: 10px;
            border-radius: 15px;
          }

        #   #entry:selected {
        #     background-color: #00725f;
        #   }

          #text {
            margin: 2px;
          }
        # '';
    };
  };
}
