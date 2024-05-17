{
  flake.nixosModules.hyprlock = {
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
      home.packages = [pkgs.fastfetch];

      # home.file.".config/fastfetch/config.jsonc".text = ''

      # '';
    };
  };
}
