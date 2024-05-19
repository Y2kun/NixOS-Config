{
  flake.nixosModules.fastfetch = {
    lib,
    config,
    pkgs,
    ...
  }: {
    options = {
      programs.fastfetch = {
        enable = lib.mkEnableOption "fastfetch";
      };
    };

    config = lib.mkIf config.programs.fastfetch.enable {
      # home.packages = [pkgs.fastfetch];

      programs.file.".config/fastfetch/config.jsonc".text = ''
          {
          "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
          "modules": [
            "title",
            "separator",
            "os",
            "host",
            "kernel",
            "uptime",
            "packages",
            "shell",
            "display",
            "de",
            // "wm",
            // "wmtheme",
            // "theme",
            // "icons",
            // "font",
            "cursor",
            // "terminal",
            // "terminalfont",
            "cpu",
            "gpu",
            "memory",
            "swap",
            "disk",
            // "localip",
            "battery",
            "poweradapter",
            "locale",
            "break",
            "colors"
          ]
        }
      '';
    };
  };
}
