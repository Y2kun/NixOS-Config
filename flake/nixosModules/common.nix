{
  inputs,
  self,
  ...
}: let
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

    fonts = {
      packages = with pkgs; [
        font-awesome
        corefonts
        dejavu_fonts
        ipafont
        liberation_ttf
        noto-fonts-cjk
        noto-fonts-emoji
        fira
        fira-code
        # fira-code-nerd
        fira-code-symbols
        fira-mono
      ];

      fontconfig.defaultFonts = {
        monospace = ["Fira Code" "IPAGothic"];
        sansSerif = ["DejaVu Sans" "IPAPGothic"];
        serif = ["DejaVu Serif" "IPAPMincho"];
        emoji = ["Noto Fonts Emoji"];
      };
    };

    time.timeZone = "Europe/Vienna";

    users.users.yuma = {
      isNormalUser = true;
      name = "yuma";
      group = "users";
      createHome = true;
      home = "/home/yuma";
      description = "Yuma Fellinger";
      extraGroups = ["networkmanager" "wheel" "kvm" "audio" "video" "pulsaudio"];
      hashedPassword = "$y$j9T$oNlXtRUJQNJDNQmHXPWxk1$Y0i0NUdvHVgJA3jVKCGSTO3B3ecZyX5n2ss.v.PoZE7";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGsbfq4tmdaxVCKZjOMdhDIN1hCTa8+3eMFqBjBMKhB3 yuma@kappa"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHqClYCBF8xmXWpaQfUJQ9OIAbK+FyFgDzgTW+KowZWz yuma@lambda"
      ];
      shell = "${pkgs.fish}/bin/fish";
    };

    systemd.services = {
      systemd-udev-settle.enable = false;
      NetworkManager-wait-online.enable = false;
    };

    home-manager.users.yuma = _: {
      imports = [
        self.nixosModules.helix
        self.nixosModules.hyprland
        self.nixosModules.hyprlock
      ];

      home = {
        # packages = with pkgs; [plasma-browser-integration];
        pointerCursor = {
          gtk.enable = true;
          # package = pkgs.bibata-cursors;
          # name = "Bibata-Modern-Classic";
          package = pkgs.afterglow-cursors-recolored;
          name = "Afterglow-Cursours-Recolored-Dracula-Cyan";
          # package = pkgs.phinger-cursors;
          # name = "Default"; # Doubtfull how this works
          size = 12;
        };
      };

      services = {
        # flameshot.enable = true;
        dunst = {
          enable = true;
          settings = {
            global = {
              follow = "mouse";
              width = 300;
              height = 300;
              notification_limit = 10;
              offset = "0x5";
              progress_bar = true;
              progress_bar_height = 10;
              progress_bar_frame_width = 1;
              origin = "top-center";
              transparency = 10;
              corner_radius = 5;
              frame_width = 3;
              font = "Fira";
            };

            urgency_normal = {
              foreground = "#ffffff";
              background = "#003020";
              frame_color = "#00f4cc";
              timeout = 5;
            };
            urgency_critical = {
              foreground = "#ffffff";
              background = "#aa3020";
              frame_color = "#ff040c";
              timeout = 5;
            };
          };
        };
      };

      programs = {
        home-manager.enable = true;
        btop.enable = true;
        gh.enable = true;

        git = {
          enable = true;
          userName = "Y2kun";
          userEmail = "me@y2kun.dev";
        };

        alacritty = {
          enable = true;

          # general = {
          #   shell.program = "fish";
          # };

          settings = {
            window = {
              opacity = 0.9;
            };

            scrolling = {
              history = 100000;
              multiplier = 5;
            };

            font = {
              normal = {
                family = "Fira Code";
                style = "Regular";
              };

              size = 14;
            };

            colors = {
              primary = {
                foreground = "#dddddd";
                background = "#0f0f0f";
              };

              cursor = {
                text = "#00ffaa";
                cursor = "#00aa11";
              };
            };
          };
        };

        wofi = {
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
              font-family: JetBrainsMono;
              color: #e5e9f0;
              background: transparent;
            }

            #window {
              background: #111111;
              margin: auto;
              padding: 10x;
              border-radius: 5px;
              border: 3px solid #00f4cc;
            }

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

            #entry:selected {
              background-color: #00725f;
            }

            #text {
              margin: 2px;
            }
          '';
        };

        waybar = {
          enable = true;
          systemd.enable = true;
          style = ''
            * {
              background: transparent;
              font-family: Fira;
              font-size: 14px;
              padding: 1px;
            }

            window#waybar {
              background: rgba(0, 0, 0, 0.55);
            }

            #language, #temperature, #battery, #tray, #wireplumber, #disk, #cpu, #memory, #clock, #network {
              background: transparent;
              color: white;
              background: rgba(0, 0, 0, 0.5);
              border-radius: 25%;
              border: 1px solid rgba(0, 170, 170, 0.3);
            }

            #workspaces button {
              color: #fff;
              background: rgba(0, 0, 0, 0.5);
              border-radius: 45%;
              border: 2px solid rgba(255, 255, 255, 0.3);
              padding-left: 5px;
              padding-right: 5px;
            }

            #workspaces button.active {
              background: rgba(0, 170, 170, 0.7);
            }

            #workspaces button:hover {
              background: rgba(0, 200, 200, 0.8);
            }
          '';
          settings = {
            mainBar = {
              layer = "top";
              position = "top";
              # height = ;
              # width = ;
              # margin = "5";
              margin-top = 0;
              # "margin-<top|left|bottom|right>" = 5;
              spacing = 10;
              mode = "dock";
              reload_style_on_change = true;

              modules-left = [
                # "hyprland/mode"
                "hyprland/language"
              ];

              modules-center = [
                "hyprland/workspaces"
              ];

              modules-right = [
                "tray"
                "wireplumber"
                "disk"
                "cpu"
                "memory"
                "temperature"
                "network"
                "battery"
                "clock"
                # "keyboard-state"
                # "backlight"
              ];

              tray = {
                show-passive-items = true;
              };

              wireplumber = {
                format = "{icon} {volume:2}%";
                format-bluetooth = "{icon} {volume}%";
                format-muted = "MUTE";
                format-icons = {
                  headphones = "";
                  handsfree = "";
                  headset = "";
                  phone = "";
                  portable = "";
                  car = "";
                  default = ["🔈" "🔉" "🔊"];
                };
                on-click-left = "exec pavucontrol";
              };

              disk = {
                format = " {}%";
                tooltip-format = "{used} / {total} used";
              };

              cpu = {
                format = " {usage}%";
              };

              memory = {
                format = " {}%";
                tooltip-format = "{used:0.1f}G / {total:0.1f}G used";
              };

              temperature = {
                critical-threshold = 80;
                format = "{icon} {temperatureC}°C";
                format-icons = ["" "" "" "" ""];
              };

              "network#disconnected" = {
                tooltip-format = "No connection!";
                format-ethernet = "";
                format-wifi = "";
                format-linked = "";
                format-disconnected = "";
                on-click = "nm-connection-editor";
              };

              "network#ethernet" = {
                interface = "enp*";
                format-ethernet = "";
                format-wifi = "";
                format-linked = "";
                format-disconnected = "";
                tooltip-format = "{ifname}: {ipaddr}/{cidr}";
                on-click = "nm-connection-editor";
              };

              "network#wifi" = {
                interface = "wlp*";
                format-ethernet = "";
                format-wifi = " {essid} ({signalStrength}%)";
                format-linked = "";
                format-disconnected = "";
                tooltip-format = "{ifname}: {ipaddr}/{cidr}";
                on-click = "nm-connection-editor";
              };

              "network#vpn" = {
                interface = "tun0";
                format = "";
                format-disconnected = "";
                tooltip-format = "{ifname}: {ipaddr}/{cidr}";
                on-click = "nm-connection-editor";
              };

              battery = {
                format = "{icon} {capacity}%";
                format-alt = "{time} {icon}";
                tooltip-format = "{power}";
                format-icons = ["" "" "" "" ""];
                # format-charging = " {capacity}%";
                format-plugged = " { capacity}%";
                interval = 5;
                states = {
                  warning = 20;
                  critical = 10;
                };

                # format-discharging = "{capacity}% {icon}";
                # format-charging = "{capacity}% {icon}";
                # format-plugged = "{icon} {capacity}%";
                # format-icons = {
                #   default = ["" "" "" "" "" "" "" "" "" ""];
                #   charging = ["" "" "" "" "" "" "" ""];
                #   plugged = "ﮣ";
                # };
              };

              clock = {
                format = "{:%a %d %b %H:%M}";
                # tooltip-format = "{}";
              };

              "hyprland/language" = {
                format-jp = "JP";
                format-de = "DE";
              };

              # "hyprland/workspaces" = {
              #   format = "{icons}";
              #   format-icons = {
              #     default = "0";
              #     active = "1";
              #     critical = "8";
              #   };
              # };
            };
          };
        };

        hyprlock.enable = true;

        lf = {
          # enable = true;

          settings = {
            preview = true;
            hidden = true;
            drawbox = true;
            icons = true;
            ignorecase = true;
          };
        };

        zoxide.enable = true;
        fish = {
          enable = true;
          shellAliases = {
            # "ls" = "ls -ach";
            "ls" = "eza";
            "eza" = "eza -a --icons";
            # "neofetch" = "fastfetch";
            "ff" = "fastfetch";
            "mc" = "musikcube";
            "tm" = "tmatrix -s 17";
            "clock" = "tty-clock -sc";
          };

          interactiveShellInit = ''
            set fish_greeting # Disable greeting
          '';

          loginShellInit = "pfetch";
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
              -- color_scheme = "Seti (Gogh)",
              -- color_scheme = "Atelier Plateau (base16)",
              color_scheme = "Argonaut",
              enable_wayland = true,
              window_background_opacity = 0.9,
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
      };

      gtk = {
        enable = true;
        theme = {
          name = "Breeze-Dark";
          package = pkgs.libsForQt5.breeze-gtk;
        };
      };
    };

    services = {
      accounts-daemon.enable = true;
      atd.enable = true;
      colord.enable = true;
      devmon.enable = true;
      fstrim.enable = true;
      fwupd.enable = true;
      gnome.at-spi2-core.enable = true;
      gnome.gnome-keyring.enable = true;
      # flatpak.enable = true;
      # printing.enable = true;
      radicale.enable = false;
      udisks2.enable = true;

      openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
      };

      hardware.openrgb.enable = true;

      kmscon = {
        enable = true;
        hwRender = true;
      };

      desktopManager = {
        plasma6.enable = true;
        # plasma5.enable = true;
        # plasma6.runUsingSystemd = true;
      };

      displayManager = {
        # defaultSession = "plasma";
        # defaultSession = "plasmawayland";
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };

      xserver = {
        enable = true;
        autorun = true;
        exportConfiguration = true;
        enableCtrlAltBackspace = true;
        autoRepeatInterval = 20;
        autoRepeatDelay = 150;

        # xkb = {
        #   layout = "jp, de";
        #   model = "jp106";
        #   options = "ctrl:nocap, sgrp:alt_shift_toggle";
        # "shift:both_capslock_cancel"
        # "terminate+ctrl_alt_bksp"
        # "japan:hztg_escape, ctrl:nocaps, grp:alt_shift_toggle"

        # options = __concatStringsSep "," [
        #   # "shift:both_capslock_cancel"
        #   # "terminate+ctrl_alt_bksp"
        #   "japan:hztg_escape"
        #   "ctrl:nocaps"
        #   "grp:alt_shift_toggle"
        # ];
        # };
      };
    };

    console = {
      font = "Fira Code";
      keyMap = "jp106";
    };

    # services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };

    environment.plasma6.excludePackages = with pkgs.libsForQt5; [
      konsole
      oxygen
      spectacle
      kate
      kwrited
    ];

    environment.systemPackages = with pkgs; [
      # meson
      # wayland-protocol
      # wlroots
      alejandra # formats nix files
      amberol # for playing single tracks. usefull for testing
      anki # learning cards maker and manager for learning
      aseprite # pixel art editor
      audacity # for editing audio
      bat # returns file content like cat, looks better
      blender # for making 3d stuff
      brightnessctl # for Controling the screenbrightness
      catnip # audio visualizer
      comma # runs programs without install
      darkhttpd # for running html websites
      # dooit # Console To-do list
      dust # for finding heavy files/directories
      eza # modern ls
      fastfetch # Basic Info about System
      fd # find files
      figlet # for creating Title Text
      file # determines filetypes
      firefox # browser of choice
      fzf # fuzzy file finder
      gimp # Opensource Photoshop
      gitui # similar to github but from terminal
      glow # for looking at markdown text
      godot_4 # a gameengine
      grimblast # For taking screenshots that go into the clipboard
      # htop # performance
      inkscape # vectorgraphic editor
      # itch # many free games
      jq # Json formater
      krita # In some ways better than gimp
      libreoffice # it's libre office
      # lite-xl # editor i used for lobster
      lutris # Games launcher
      magic-wormhole # for transfering data
      marksman # Markdown LSP
      # morgen # calendar
      musikcube # Music player from Command-line
      ncdu # manualy find heavy data
      networkmanagerapplet # For easily managing the local network
      nil # lsp for nix
      # nixpkgs-unstable.obsidian # where all my personal notes are
      # nixpkgs-unstable.signal-desktop # a messenging app
      obsidian
      obs-studio # screenrecorder
      openshot-qt # video editor
      pavucontrol # audio manager
      pfetch # small, fast neofetch, for shell init
      plasma5Packages.kmail
      prismlauncher # My minecraft instance manager of choice
      puddletag # song metadata editor
      qalculate-gtk # advanced calculator
      qjackctl
      ripgrep # find specific stuff, looks and functions better than fd
      ruby # high level object oriented language
      rubyPackages.solargraph # lsp for ruby
      signal-desktop
      speedtest-rs # Intertet speed test with a few extra infos
      starship # give helpful information and looks cool
      swww # for backgrounds
      syncthing # for syncing data between devices
      syncthingtray-minimal # the convinient tray for syncthing
      # tauon # music player
      tig # display the commit history of a git repo, installed for my father
      tmatrix # cool looking matrix effect
      tree # lists directory as a tree
      tty-clock # a clock in the terminal
      units # converts units
      unzip # unzips something
      vlc # plays media
      vscodium # code editor
      watchexec # execute something when something
      wayland-utils
      wget # installing from url
      whatsapp-for-linux
      wiki-tui # Wikipedia but from the terminal
      wl-clipboard
      wpsoffice # Libre office alternative
      xdotool # automate inputs
      xfce.thunar # gui file manager from xfce
      zellij # Terminal Partitioner
      zip # zips something
    ];

    hardware = {
      steam-hardware.enable = true;
    };

    environment.variables = {
      EDITOR = "helix";
      BROWSER = "firefox";
      TERMINAL = "wezterm";

      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";

      # Hint Electon apps to use wayland
      NIXOS_OZONE_WL = "1";
      CLUTTER_BACKEND = "wayland";
      XDG_SESSION_TYPE = "wayland";

      LC_CTYPE = "en_US.UTF-8";
      LESS = "-M";
      MINICOM = "-c on";
      PAGER = "less -rX";
      MANPAGER = "less -rX";
      ASPELL_CONF = "dict-dir ${pkgs.aspell}/lib/aspell";

      OMNISHARPHOME = let
        omnisharp-configuration = {
          FormattingOptions = {
            EnableEditorConfigSupport = true;
            OrganizeImports = true;
            NewLine = "\n";
            UseTabs = true;
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
            IndentBlock = false;
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

      hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      command-not-found.enable = false;
      dconf.enable = true;
      nm-applet.enable = true;
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
