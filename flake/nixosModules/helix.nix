{
  flake.homeModules.helix = {
    config,
    lib,
    pkgs,
    ...
  }: {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "tokyonight_transparent";
        editor = {
          auto-completion = true;
          auto-format = true;
          bufferline = "multiple";
          cursorline = true;
          mouse = true;
          line-number = "relative";
        };

        editor.cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        editor.indent-guides = {
          character = "╎";
          render = true;
        };

        editor.statusline = {
          mode.normal = "Normal";
          mode.insert = "Insert";
          mode.select = "Select";
          left = ["mode" "spinner" "version-control" "file-name"];
        };

        editor.smart-tab = {
          enable = true;
        };

        keys.normal = {
          esc = ["collapse_selection" "keep_primary_selection"];
        };
      };

      languages = {
        language-server.c-sharp = {
          command = "omnisharp";
          args = ["-lsp"];
          timeout = 10000;
        };

        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "alejandra";
              args = ["-"];
            };
          }
          {
            name = "c-sharp";
            scope = "source.cs";
            injection-regex = "c-?sharp";
            roots = ["sln" "csproj"];
            file-types = ["cs"];
            comment-token = "//";
            indent = {
              tab-width = 4;
              unit = "    ";
            };
          }
        ];
        themes = {
          tokyonight_transparent = {
            "inherits" = "tokyonight";
            "ui.background" = {};
          };
        };
      };
    };
  };
}
