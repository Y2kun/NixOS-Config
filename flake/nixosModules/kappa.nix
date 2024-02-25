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
      loader.grub = {
        enable = true;
        device = "/dev/disk/by-id/ata-TS480GSSD220S_B915817AE427622F0618";
      };

      vesa = true;
      binfmt.emulatedSystems = ["aarch64-linux"];
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
    # ffmpeg-full
    # frei0r
    # gdb
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
    # mkpasswd # embeded
    # neovim
    # netcat-openbsd
    # nettools
    # ngrok
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
    # akonadi
    # akregator
    # ark
    # bluedevil
    # bovo
    # breeze-grub
    # breeze-gtk
    # breeze-icons
    # breeze-plymouth
    # breeze-qt5
    # discover
    # dragon
    # ffmpegthumbs
    # filelight
    # granatier
    # gwenview # embeded in KDE Plasma
    # k3b
    # kactivitymanagerd
    # kaddressbook
    # kalzium
    # kapman
    # kapptemplate
    # katomic
    # kblackbox
    # kblocks
    # kbounce
    # kcachegrind
    # kcalc
    # kcharselect
    # kcolorchooser
    # kde-cli-tools
    # kde-gtk-config
    # kdenlive
    # kdf
    # kdialog
    # kdiamond
    # keditbookmarks
    # kfind
    # kfloppy
    # kgamma5
    # kget
    # kgpg
    # khelpcenter
    # kig
    # kigo
    # killbots
    # kinfocenter
    # kitinerary
    # kleopatra
    # klettres
    # klines
    # kmag
    # kmenuedit
    # kmines
    # kmix
    # kmplot
    # knavalbattle
    # knetwalk
    # knights
    # kollision
    # kolourpaint
    # kompare
    # kontact
    # korganizer
    # kpkpass
    # krdc
    # kreversi
    # krfb
    # krohnkite
    # kscreen
    # kscreenlocker
    # kshisen
    # ksshaskpass
    # ksystemlog
    # kwallet-pam
    # kwave
    # kwayland-integration
    # kwin
    # kwrited
    # libksysguard
    # marble
    # milou
    # minuet
    # okular
    # oxygen
    # oxygen-icons5
    # picmi
    # plasma-browser-integration
    # plasma-desktop
    # plasma-integration
    # plasma-nm
    # plasma-pa
    # plasma-systemmonitor
    # plasma-thunderbolt
    # plasma-vault
    # plasma-workspace
    # plasma-workspace-wallpapers
    # polkit-kde-agent
    # powerdevil
    # qqc2-breeze-style
    # sddm-kcm
    # spectacle
    # systemsettings
    # xdg-desktop-portal-kde
    # yakuake
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
    # which # embeded
    # xarchiver
    # xdg_utils
    # xfsprogs
    # xmrig
    # xorg.xhost
    # xorg.xwininfo
    # yq
    # }

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

    xdg = {
      portal.enable = true;
      portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };

    hardware = {
      enableRedistributableFirmware = true;

      cpu.intel.updateMicrocode = true;

      opengl = {
        driSupport32Bit = true;
        enable = true;
        extraPackages32 = [pkgs.pkgsi686Linux.libva];
      };

      nvidia.modesetting.enable = true;

      steam-hardware.enable = true;

      bluetooth = {
        enable = true;
        package = pkgs.bluez;
      };
    };

    security = {
      audit.enable = false;

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

      wrappers = {
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
    };

    # programs = {
    #   adb.enable = true;
    #   dconf.enable = true;
    #   mosh.enable = true;
    #   gnupg.agent.pinentryFlavor = "qt";
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
