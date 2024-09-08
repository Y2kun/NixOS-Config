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

      # style = ''
      # '';
    };
  };
}
