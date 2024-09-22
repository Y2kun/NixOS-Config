{inputs, ...}: {
  flake.nixosModules.lambda = {
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

    system.stateVersion = "22.05";

    services = {
      avahi.enable = true;

      # fprintd.enable = true;
      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;
      touchegg.enable = true;
      # videoDrivers = ["amdgpu"];
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

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

    environment.systemPackages = with pkgs; [
      # armcord
      bluez

      (discord-canary.override {
        # withOpenASAR = true;
        withVencord = true;
      })

      # wireshark
      # lazydocker
      # docker
      # docker-client
      # docker-compose
      # logisim-evolution
      whatsapp-for-linux
      protonvpn-gui
      qemu
      teams-for-linux
      # virtualbox
      virt-manager
      wine
      jetbrains.goland
      jetbrains.idea-ultimate
      scenebuilder
      ciscoPacketTracer8
    ];

    home-manager.users.yuma = _: {
      home = {
        username = "yuma";
        homeDirectory = "/home/yuma";
        stateVersion = "23.05";
      };
      wayland.windowManager.hyprland.settings.monitor = [
        "eDP-1, prefered, auto, 1"
      ];
    };

    services = {
      # Enable TLP (better than gnomes internal power manager)
      tlp = {
        enable = true;
        settings = {
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        };
      };
      # Disable GNOMEs power management
      power-profiles-daemon.enable = false;
      # Enable thermald (only necessary if on Intel CPUs)
      thermald.enable = true;

      blueman.enable = true;
    };

    # Enable powertop
    powerManagement.powertop.enable = true;

    systemd.services.home-manager-yuma.environment.HOME = "/home/yuma";

    virtualisation.kvmgt.enable = true;
    virtualisation.libvirtd.enable = true;

    # Bootloader.
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot/efi";
      };
      initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      initrd.kernelModules = [];
      extraModulePackages = [];
      kernelModules = ["kvm-amd"];
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/05953257-79bf-4a5b-938e-760a1c033d80";
        fsType = "ext4";
      };

      "/boot/efi" = {
        device = "/dev/disk/by-uuid/CAF8-8EC8";
        fsType = "vfat";
      };
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/fe6892c3-09c2-4cf5-abe0-71cea4090d52";}
    ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking = {
      useDHCP = lib.mkDefault true;
      # interfaces.enp2s0.useDHCP = lib.mkDefault true;
      # interfaces.wlp3s0.useDHCP = lib.mkDefault true;

      hostName = name;
      networkmanager.enable = true;
    };

    hardware = {
      cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      nvidia.prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        # integrated
        amdgpuBusId = "PCI:7:0:0";
      };
    };
  };
}
