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
  flake.nixosModules.kappa = {
    name,
    config,
    pkgs,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/17d0c8c2-2a33-4cad-ae8e-a05e03443390";
      fsType = "ext4";
    };

    system.stateVersion = "20.09";

    console = {
      font = "lat9w-16";
      keyMap = "us";
    };

    boot = {
      initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      kernel.sysctl."kernel.sysrq" = 16;
      tmp.cleanOnBoot = true;
      kernelModules = ["kvm-intel" "uinput" "i2c_dev"];
    };

    environment.systemPackages = with pkgs; [
      nixpkgs-unstable.r2modman # modloader for some games
      # nixpkgs-unstable.stt
      # nixpkgs-unstable.tts
    ];

    # packages i "used" {
    # acpi
    # apacheHttpd
    # apostrophe
    # ardour
    # aria2
    # atool
    # audio-recorder
    # awscli
    # bc
    # bind
    # binutils
    # bitwarden-cli
    # blueman
    # bottom
    # break-time
    # carapace
    # cargo
    # cdrkit
    # cdrtools
    # cheat
    # cloc
    # cmatrix
    # cntr
    # cryptsetup
    # curl
    # di
    # ding
    # discount
    # dmidecode
    # drumgizmo
    # dvdauthor
    # elvish
    # exfat
    # falkon
    # ffmpeg-full
    # frei0r
    # gdb
    # gh
    # ghq
    # gsmartcontrol
    # guitarix
    # gvfs # usb mounting support
    # helm
    # hugo
    # hydrogen
    # iftop
    # iotop
    # jack2Full
    # jfsutils
    # jiq
    # jq
    # kbfs
    # keybase
    # libcaca
    # libnotify
    # libsForQt5.breeze-gtk
    # libxfs
    # lilypond
    # linuxPackages.bcc
    # lm_sensors
    # (lowPrio inetutils)
    # (lowPrio man-pages)
    # lshw
    # lsof
    # ltrace
    # lunar-client
    # lxmenu-data # show installed applications when opening file
    # mkpasswd
    # neovim
    # netcat-openbsd
    # nettools
    # ngrok
    # nix-index
    # nixpkgs-unstable.electron_25
    # nix-prefetch-scripts
    # nix-top
    # nmap
    # nordic
    # openrgb
    # parted
    # partition-manager
    # patchelf
    # pciutils
    # pcmanfm
    # pgcli
    # pixelorama
    # plasma5Packages.akonadi
    # plasma5Packages.akregator
    # plasma5Packages.ark
    # plasma5Packages.bluedevil
    # plasma5Packages.bovo
    # plasma5Packages.breeze-grub
    # plasma5Packages.breeze-gtk
    # plasma5Packages.breeze-icons
    # plasma5Packages.breeze-plymouth
    # plasma5Packages.breeze-qt5
    # plasma5Packages.discover
    # plasma5Packages.dolphin
    # plasma5Packages.dragon
    # plasma5Packages.elisa
    # plasma5Packages.ffmpegthumbs
    # plasma5Packages.filelight
    # plasma5Packages.granatier
    # plasma5Packages.gwenview
    # plasma5Packages.k3b
    # plasma5Packages.kactivitymanagerd
    # plasma5Packages.kaddressbook
    # plasma5Packages.kalzium
    # plasma5Packages.kapman
    # plasma5Packages.kapptemplate
    # plasma5Packages.kate
    # plasma5Packages.katomic
    # plasma5Packages.kblackbox
    # plasma5Packages.kblocks
    # plasma5Packages.kbounce
    # plasma5Packages.kcachegrind
    # plasma5Packages.kcalc
    # plasma5Packages.kcharselect
    # plasma5Packages.kcolorchooser
    # plasma5Packages.kde-cli-tools
    # plasma5Packages.kde-gtk-config
    # plasma5Packages.kdenlive
    # plasma5Packages.kdf
    # plasma5Packages.kdialog
    # plasma5Packages.kdiamond
    # plasma5Packages.keditbookmarks
    # plasma5Packages.kfind
    # plasma5Packages.kfloppy
    # plasma5Packages.kgamma5
    # plasma5Packages.kget
    # plasma5Packages.kgpg
    # plasma5Packages.khelpcenter
    # plasma5Packages.kig
    # plasma5Packages.kigo
    # plasma5Packages.killbots
    # plasma5Packages.kinfocenter
    # plasma5Packages.kitinerary
    # plasma5Packages.kleopatra
    # plasma5Packages.klettres
    # plasma5Packages.klines
    # plasma5Packages.kmag
    # plasma5Packages.kmenuedit
    # plasma5Packages.kmines
    # plasma5Packages.kmix
    # plasma5Packages.kmplot
    # plasma5Packages.knavalbattle
    # plasma5Packages.knetwalk
    # plasma5Packages.knights
    # plasma5Packages.kollision
    # plasma5Packages.kolourpaint
    # plasma5Packages.kompare
    # plasma5Packages.konsole
    # plasma5Packages.kontact
    # plasma5Packages.korganizer
    # plasma5Packages.kpkpass
    # plasma5Packages.krdc
    # plasma5Packages.kreversi
    # plasma5Packages.krfb
    # plasma5Packages.krohnkite
    # plasma5Packages.kscreen
    # plasma5Packages.kscreenlocker
    # plasma5Packages.kshisen
    # plasma5Packages.ksshaskpass
    # plasma5Packages.ksystemlog
    # plasma5Packages.kwallet-pam
    # plasma5Packages.kwave
    # plasma5Packages.kwayland-integration
    # plasma5Packages.kwin
    # plasma5Packages.kwrited
    # plasma5Packages.libksysguard
    # plasma5Packages.marble
    # plasma5Packages.milou
    # plasma5Packages.minuet
    # plasma5Packages.okular
    # plasma5Packages.oxygen
    # plasma5Packages.oxygen-icons5
    # plasma5Packages.picmi
    # plasma5Packages.plasma-browser-integration
    # plasma5Packages.plasma-desktop
    # plasma5Packages.plasma-integration
    # plasma5Packages.plasma-nm
    # plasma5Packages.plasma-pa
    # plasma5Packages.plasma-systemmonitor
    # plasma5Packages.plasma-thunderbolt
    # plasma5Packages.plasma-vault
    # plasma5Packages.plasma-workspace
    # plasma5Packages.plasma-workspace-wallpapers
    # plasma5Packages.polkit-kde-agent
    # plasma5Packages.powerdevil
    # plasma5Packages.qqc2-breeze-style
    # plasma5Packages.sddm-kcm
    # plasma5Packages.spectacle
    # plasma5Packages.systemsettings
    # plasma5Packages.xdg-desktop-portal-kde
    # plasma5Packages.yakuake
    # pmount
    # pmutils
    # powertop
    # procps
    # pv
    # pwgen
    # ranger
    # rsync
    # rubocop
    # rubyPackages.sorbet
    # rust
    # screen
    # setroot
    # shared-mime-info # recognize different file types
    # shfmt
    # smartmontools
    # sshfs-fuse
    # sysstat
    # tagainijisho
    # tmate
    # ts
    # tty-share
    # up
    # usbutils
    # wget
    # which
    # xarchiver
    # xdg_utils
    # xfsprogs
    # xmrig
    # xorg.xhost
    # xorg.xwininfo
    # yq
    # zanshin
    # }

    boot = {
      loader.grub = {
        enable = true;
        device = "/dev/disk/by-id/ata-TS480GSSD220S_B915817AE427622F0618";
      };
      vesa = true;
      binfmt.emulatedSystems = ["aarch64-linux"];
    };

    services = {
      resolved = {
        enable = false;
        fallbackDns = ["100.65.0.1" "192.168.178.1" "1.1.1.1"];
        # domains = ["fritz.box"];
        domains = ["~."];
        extraConfig = ''
          DNSOverTLS=yes
        '';
      };

      udev.packages = [pkgs.fuse];

      nextdns = {
        enable = true;
        arguments = [
          "-config"
          "ac4b8a"
          "-report-client-info"
          "-forwarder"
          "fritz.box=192.168.178.1"
        ];
      };

      smartd = {
        enable = true;
        notifications = {
          test = true;
          x11.enable = true;
        };
      };

      xserver = {
        xrandrHeads = ["DP-0"];
        videoDrivers = ["nvidia"];
        serverLayoutSection = ''
          Option "AIGLX" "true"
        '';
      };
    };

    networking = {
      hostName = name;
      nameservers = ["127.0.0.1"];

      networkmanager = {
        enable = lib.mkDefault true;
        dns = "default";
        unmanaged = ["docker0" "virbr0"];
      };

      firewall = {
        enable = true;
        allowPing = true;

        allowedTCPPorts = [
          139 # netbios
          445 # smb
          22000 # syncthing
        ];

        allowedUDPPorts = [
          137 # netbios
          138 # smb
          21027 # syncthing
          34197 # Factorio
          34613 # Factorio
        ];

        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ]; # KDE Connect

        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ]; # KDE Connect
      };
    };

    # systemd.user.services.emacs.serviceConfig.Environment = ["LC_CTYPE=zh_CN.UTF-8"];

    systemd.extraConfig = ''
      DefaultLimitNOFILE=1048576
    '';

    # users.users.yuma = {
    #   isNormalUser = true;
    #   name = "yuma";
    #   group = "users";
    #   uid = 1001;
    #   createHome = true;
    #   home = "/home/yuma";
    #   shell = "${pkgs.fish}/bin/fish";
    #   hashedPassword = "$y$j9T$56qD2JdCVL4j0ES1Nmfj.0$.bK7fz0W9uY.S.1om3memBRP9UU90YxJRmUNPMTtCJ1";
    #   extraGroups = [
    #     "adbusers"
    #     "audio"
    #     # "docker"
    #     "i2c"
    #     "input"
    #     "kvm"
    #     "libvirtd"
    #     "lp"
    #     "pulseaudio"
    #     "scanner"
    #     "steam"
    #     "video"
    #     "wheel"
    #   ];
    # };

    powerManagement = {
      enable = true;
      cpuFreqGovernor = lib.mkDefault "ondemand";
    };

    xdg.portal.enable = true;

    hardware = {
      enableRedistributableFirmware = true;

      cpu.intel.updateMicrocode = true;

      opengl = {
        driSupport32Bit = true;
        enable = true;
        extraPackages32 = [pkgs.pkgsi686Linux.libva];
      };

      steam-hardware.enable = true;

      bluetooth = {
        enable = true;
        package = pkgs.bluez;
      };
    };

    security = {
      pam = {
        loginLimits = [
          {
            domain = "*";
            item = "nofile";
            type = "hard";
            value = "1048576";
          }
        ];
      };
      audit.enable = false;
    };

    security.wrappers = {
      pmount = {
        source = "${pkgs.pmount}/bin/pmount";
        owner = "root";
        group = "root";
        setuid = true;
      };

      pumount = {
        source = "${pkgs.pmount}/bin/pumount";
        owner = "root";
        group = "root";
        setuid = true;
      };
    };

    # programs = {
    # adb.enable = true;
    # dconf.enable = true;
    # mosh.enable = true;
    # gnupg.agent.pinentryFlavor = "qt";
    # };

    # FIXME: Ugly hack to make home-manager obey??
    systemd.services.home-manager-yuma.environment.HOME = "/home/yuma";

    home-manager.verbose = false;

    home-manager.users.yuma = _: {
      home.file.".Xmodmap".text = ''
        keycode 102 = Super_L
      '';

      xdg.enable = true;

      home.stateVersion = "20.09";
      home.homeDirectory = lib.mkForce "/home/yuma";
      home.username = "yuma";

      home.sessionVariables = {
        BROWSER = "firefox";
        LC_CTYPE = "en_US.UTF-8";
        PAGER = "less -R";

        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIER = "@im=fcitx";
        XMODIFIERS = "@im=fcitx";

        RIPGREP_CONFIG_PATH = builtins.toFile "ripgreprc" ''
          --smart-case
        '';
      };

      # gtk = with pkgs.gnome3; {
      #   iconTheme.package = gnome_themes_standard;
      #   theme.package = gnome_themes_standard;
      # };

      programs = {
        gpg.settings = {keyserver-options = "auto-key-retrieve";};
        # feh.enable = true;
      };
    };
  };
}
