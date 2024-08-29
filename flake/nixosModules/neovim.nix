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
        nvchad-ui
        vim-nix
        nvim-tree
        nvim-treesitter.withPlugins
        (lang: [
          # lang.bash
          lang.comment
          lang.css
          lang.dockerfile
          lang.fish
          lang.gitattributes
          lang.gitignore
          # lang.go
          # lang.gomod
          # lang.gowork
          # lang.hcl
          lang.javascript
          # lang.jq
          # lang.json5
          lang.json
          lang.lua
          lang.make
          lang.markdown
          lang.nix
          lang.python
          lang.rust
          lang.toml
          # lang.typescript
          # lang.vue
          lang.yaml
        ])
      ];
      extraConfig = {
      };
      extraLuaConfig = {
      };
    };
  };
}
