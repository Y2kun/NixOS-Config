{inputs, ...}: let
  nixpkgs-unstable = (import inputs.nixpkgs-unstable) {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
    system = "x86_64-linux";
  };
in {
  flake.nixosModules.common = {pkgs, ...}: {
    i18n = {
      defaultLocale = "de_AT.UTF-8";
      inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [fcitx5-configtool fcitx5-anthy];
        ibus.panel = "${pkgs.plasma5Packages.plasma-desktop}/lib/libexec/kimpanel-ibus-panel";
      };

      extraLocaleSettings = {
        LC_ADDRESS = "de_AT.utf8";
        LC_IDENTIFICATION = "de_AT.utf8";
        LC_MEASUREMENT = "de_AT.utf8";
        LC_MONETARY = "de_AT.utf8";
        LC_NAME = "de_AT.utf8";
        LC_NUMERIC = "de_AT.utf8";
        LC_PAPER = "de_AT.utf8";
        LC_TELEPHONE = "de_AT.utf8";
        LC_TIME = "de_AT.utf8";
      };
    };

    fonts.packages = with pkgs; [
      corefonts
      dejavu_fonts
      ipafont
      liberation_ttf
      noto-fonts-cjk
      noto-fonts-emoji
      fira
      fira-code
      fira-code-symbols
      fira-mono
    ];

    fonts.fontconfig.defaultFonts = {
      monospace = ["Fira Code" "IPAGothic"];
      sansSerif = ["DejaVu Sans" "IPAPGothic"];
      serif = ["DejaVu Serif" "IPAPMincho"];
      emoji = ["Noto Color Emoji"];
    };

    time.timeZone = "Europe/Vienna";

    users.users.yuma = {
      isNormalUser = true;
      name = "yuma";
      group = "users";
      createHome = true;
      home = "/home/yuma";
      description = "Yuma Fellinger";
      extraGroups = ["networkmanager" "wheel" "kvm" "audio" "video"];
      hashedPassword = "$y$j9T$oNlXtRUJQNJDNQmHXPWxk1$Y0i0NUdvHVgJA3jVKCGSTO3B3ecZyX5n2ss.v.PoZE7";
      shell = "${pkgs.fish}/bin/fish";
    };

    home-manager.users.yuma = _: {
      home.packages = with pkgs; [plasma-browser-integration];

      services = {
        flameshot.enable = true;
        pasystray.enable = true;
      };

      programs = {
        home-manager.enable = true;
        gh.enable = true;
        btop.enable = true;

        zoxide.enable = true;
        fish = {
          enable = true;
          shellAliases = {
            "ls" = "ls -ach";
            # "neofetch" = "fastfetch";
            # "ff" = "fastfetch";
          };

          interactiveShellInit = ''
            set fish_greeting # Disable greeting
          '';

          loginShellInit = "fastfetch";
          plugins = [
            {
              name = "zoxide.fish";
              src = pkgs.fetchFromGitHub {
                owner = "kidonng";
                repo = "zoxide.fish";
                rev = "bfd5947bcc7cd01beb23c6a40ca9807c174bba0e";
                sha256 = "sha256-Hq9UXB99kmbWKUVFDeJL790P8ek+xZR5LDvS+Qih+N4=";
              };
            }
          ];
        };

        starship.enable = true;
        starship.enableFishIntegration = true;

        bat = {
          enable = true;
          config = {
            pager = "less -FR";
            theme = "TwoDark";
          };
        };

        direnv = {
          enable = true;
          # enableFishIntegration = true;
        };

        wezterm = {
          enable = true;
          extraConfig = ''
            -- Your lua code / config here
            return {
              font = wezterm.font("Fira Code"),
              font_size = 14.0,
              color_scheme = "Seti (Gogh)",
              window_background_opacity = .95,
              hide_tab_bar_if_only_one_tab = true,
              keys = {
                {
                  key = "v",
                  mods = "SUPER|CTRL",
                  action = wezterm.action.SplitPane {
                    direction = "Right",
                    size = {Percent = 50},
                  }
                },

              }
            }
          '';
        };

        helix = {
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

            # editor.lsp = {
            #   enable = true;
            #   display-messages = true;
            #   display-inline-hints = true;
            #   display-signature-help-docs = true;
            #   snippets = true;
            # };

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
          };

          themes = {
            tokyonight_transparent = {
              "inherits" = "tokyonight";
              "ui.background" = {};
            };
          };
        };
      };
    };

    services = {
      colord.enable = true;
      accounts-daemon.enable = true;
      atd.enable = true;
      devmon.enable = true;
      fstrim.enable = true;
      fwupd.enable = true;
      gnome.at-spi2-core.enable = true;
      udisks2.enable = true;
      # printing.enable = true;
      gnome.gnome-keyring.enable = true;
      flatpak.enable = true;
      radicale.enable = false;

      openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
      };

      # kmscon = {
      #   enable = true;
      #   hwRender = true;
      # };

      xserver = {
        enable = true;
        autorun = true;
        exportConfiguration = true;
        enableCtrlAltBackspace = true;
        autoRepeatInterval = 30;
        autoRepeatDelay = 150;

        displayManager = {
          defaultSession = "plasma";
          # defaultSession = "plasmawayland";
          sddm = {
            enable = true;
            # wayland.enable = true;
          };
        };

        desktopManager = {
          plasma5.enable = true;
          plasma5.runUsingSystemd = true;
        };

        layout = "jp";
        xkbModel = "jp106";
        xkbOptions = __concatStringsSep "," [
          "shift:both_capslock_cancel"
          "terminate+ctrl_alt_bksp"
          "japan:hztg_escape"
          "ctrl:nocaps"
        ];
      };
    };

    environment.plasma5.excludePackages = with pkgs.libsForQt5; [
      konsole
    ];

    environment.systemPackages = with pkgs; [
      alejandra # formats nix files
      anki # learning cards maker and manager for learning
      aseprite # pixel art editor
      audacity # for editing audio
      bat # returns file content like cat, looks better
      blender # for making 3d stuff
      cmake # a c compiler
      comma # runs programs without install
      darkhttpd
      dooit # Console To-do list
      fd # find files
      file # determines filetypes
      firefox # browser of choice
      fzf # fuzzy file finder
      gimp # Opensource Photoshop
      git # it's git
      godot_4 # a gameengine
      htop # performance
      inkscape # vectorgraphic editor
      itch # many free games
      jq # Json formater
      krita # In some ways better than gimp
      libreoffice # it's libre office
      lite-xl # editor i used for lobster
      # lutris # Games launcher
      magic-wormhole # for transfering data
      marksman # Markdown LSP
      # morgen # calendar
      ncdu # manualy find heavy data
      fastfetch # Basic Info about System
      nixpkgs-unstable.obsidian # where all my personal notes are
      nixpkgs-unstable.signal-desktop # a messenging app
      obs-studio # screenrecorder
      openshot-qt # video editor
      pavucontrol # audio manager
      plasma5Packages.kdeplasma-addons
      plasma5Packages.kmail
      prismlauncher # My minecraft instance manager of choice
      puddletag # song metadata editor
      qalculate-gtk # advanced calculator
      qjackctl
      ripgrep # find specific stuff, looks and functions better than fd
      ruby # high level object oriented language
      rubyPackages.solargraph # lsp for ruby
      starship # give helpful information and looks cool
      syncthing # for syncing data between devices
      syncthingtray-minimal # the convinient tray for syncthing
      tree # lists directory as a tree
      units # converts units
      unzip # unzips something
      vlc # plays media
      vscodium # code editor
      watchexec # execute something when something
      wget # installing from url
      zip # zips something
    ];

    environment.variables = {
      EDITOR = "hx";
      LC_CTYPE = "en_US.UTF-8";
      LESS = "-M";
      MINICOM = "-c on";
      PAGER = "less -rX";
      MANPAGER = "less -rX";
      ASPELL_CONF = "dict-dir ${pkgs.aspell}/lib/aspell";
      OMNISHARPHOME = let
        omnisharp-configuration = {
          FormattingOptions = {
            EnableEditorConfigSupport = false;
            OrganizeImports = false;
            NewLine = "\n";
            UseTabs = false;
            TabSize = 4;
            IndentationSize = 4;
            SpacingAfterMethodDeclarationName = false;
            SpaceWithinMethodDeclarationParenthesis = false;
            SpaceBetweenEmptyMethodDeclarationParentheses = false;
            SpaceAfterMethodCallName = false;
            SpaceWithinMethodCallParentheses = false;
            SpaceBetweenEmptyMethodCallParentheses = false;
            SpaceAfterControlFlowStatementKeyword = true;
            SpaceWithinExpressionParentheses = false;
            SpaceWithinCastParentheses = false;
            SpaceWithinOtherParentheses = false;
            SpaceAfterCast = false;
            SpacesIgnoreAroundVariableDeclaration = false;
            SpaceBeforeOpenSquareBracket = false;
            SpaceBetweenEmptySquareBrackets = false;
            SpaceWithinSquareBrackets = false;
            SpaceAfterColonInBaseTypeDeclaration = true;
            SpaceAfterComma = true;
            SpaceAfterDot = false;
            SpaceAfterSemicolonsInForStatement = true;
            SpaceBeforeColonInBaseTypeDeclaration = true;
            SpaceBeforeComma = false;
            SpaceBeforeDot = false;
            SpaceBeforeSemicolonsInForStatement = false;
            SpacingAroundBinaryOperator = "single";
            IndentBraces = false;
            IndentBlock = true;
            IndentSwitchSection = true;
            IndentSwitchCaseSection = true;
            IndentSwitchCaseSectionWhenBlock = true;
            LabelPositioning = "oneLess";
            WrappingPreserveSingleLine = true;
            WrappingKeepStatementsOnSingleLine = true;
            NewLinesForBracesInTypes = false;
            NewLinesForBracesInMethods = false;
            NewLinesForBracesInProperties = false;
            NewLinesForBracesInAccessors = false;
            NewLinesForBracesInAnonymousMethods = false;
            NewLinesForBracesInControlBlocks = false;
            NewLinesForBracesInAnonymousTypes = false;
            NewLinesForBracesInObjectCollectionArrayInitializers = false;
            NewLinesForBracesInLambdaExpressionBody = false;
            NewLineForElse = false;
            NewLineForCatch = false;
            NewLineForFinally = false;
            NewLineForMembersInObjectInit = false;
            NewLineForMembersInAnonymousTypes = false;
            NewLineForClausesInQuery = false;
          };
        };
        json = pkgs.writeText ".omnisharp/omnisharp.json" (builtins.toJSON omnisharp-configuration);
      in "${json}";
    };

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };

      nix-index = {
        enable = true;
        enableFishIntegration = true;
      };

      command-not-found.enable = false;
    };

    swapDevices = [];
    environment.homeBinInPath = true;
    nixpkgs.config.allowUnfree = true;

    # Sound
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      socketActivation = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    documentation.dev.enable = true;

    nix = {
      registry.nixpkgs.flake = inputs.nixpkgs;
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];

      nrBuildUsers = 16;
      gc.automatic = true;
      gc.options = "--max-freed ${toString (10 * 1024 * 1024 * 1024)}";
      optimise.automatic = true;
      buildMachines = [];

      settings = {
        auto-optimise-store = true;
        cores = 12;
        gc-keep-derivations = true;
        http2 = true;
        keep-outputs = true;
        log-lines = 100;
        min-free-check-interval = 300;
        sandbox = true;
        show-trace = true;
        tarball-ttl = 60 * 60 * 24 * 30;
        warn-dirty = false;

        system-features = [
          "kvm"
          "nixos-test"
          "benchmark"
          "big-parallel"
          "recursive-nix"
        ];

        experimental-features = ["nix-command" "flakes"];
      };
    };
  };
}