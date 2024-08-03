{inputs, ...}: {
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

    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 16 * 1024;
      }
    ];

    system.stateVersion = "20.09";

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

    environment = {
      systemPackages = with pkgs; [
        r2modman # modloader for some games
      ];
    };

    services = {
      resolved = {
        enable = false;
        fallbackDns = ["100.65.0.1" "192.168.178.1" "1.1.1.1"];
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

        # You may need to comment out "services.displayManager.gdm.enable = true;"
        desktopManager.plasma5.enable = true;
      };
      displayManager.sddm.enable = true;
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

    systemd.extraConfig = ''
      DefaultLimitNOFILE=1048576
    '';

    powerManagement = {
      enable = true;
      cpuFreqGovernor = lib.mkDefault "ondemand";
    };

    hardware = {
      enableRedistributableFirmware = true;

      cpu.intel.updateMicrocode = true;

      opengl = {
        enable = true;
        driSupport32Bit = true;
        extraPackages32 = [pkgs.pkgsi686Linux.libva];
      };

      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        # package = config.boot.kernelPackages.nvidiaPackages.beta;
      };

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

    # FIXME: Ugly hack to make home-manager obey??
    systemd.services.home-manager-yuma.environment.HOME = "/home/yuma";

    home-manager.verbose = false;

    home-manager.users.yuma = _: {
      home.file.".Xmodmap".text = ''
        keycode 102 = Super_L
      '';

      wayland.windowManager.hyprland = {
        enable = lib.mkForce false;
        settings.monitor = [
          # "DP-1    , preferred, -1080x320,auto , transform, 1"
          # "HDMI-A-2, preferred, 0x0      ,auto , transform, 2"
          # "HDMI-A-1, preferred, 0x1080   ,auto , transform"
          "        , preferred, 0x0      ,auto , transform, 2"
        ];
      };

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

      programs = {
        gpg.settings = {keyserver-options = "auto-key-retrieve";};
        waybar.enable = lib.mkForce false;
      };
    };
  };
}
