{
  flake.nixosModules.neovim = {
    config,
    lib,
    pkgs,
    ...
  }: {
    programs.neovim = {
      enable = true;
      # defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        nvchad
      ];
    };
  };
}
