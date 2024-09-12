{
  flake.nixosModules.dunst = {
    config,
    lib,
    pkgs,
    ...
  }: {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          follow = "mouse";
          width = 300;
          height = 300;
          notification_limit = 10;
          offset = "7x8";
          progress_bar = true;
          progress_bar_height = 10;
          progress_bar_frame_width = 1;
          origin = "top-right";
          transparency = 8;
          corner_radius = 5;
          frame_width = 3;
        };

        # urgency_normal = {
        #   foreground = "#ffffff";
        #   background = "#003020";
        #   frame_color = "#00f4cc";
        #   timeout = 5;
        # };
        # urgency_critical = {
        #   foreground = "#ffffff";
        #   background = "#aa3020";
        #   frame_color = "#ff040c";
        #   timeout = 5;
        # };
      };
    };
  };
}
