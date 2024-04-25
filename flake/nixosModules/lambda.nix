{
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

    networking = {
      hostName = "lambda";
      networkmanager.enable = true;
    };

    services = {
      avahi.enable = true;

      # fprintd.enable = true;
      # Enable touchpad support (enabled default in most desktopManager).
      xserver.libinput.enable = true;
      touchegg.enable = true;
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
      armcord
      webcord-vencord
      (chromium.override {
        commandLineArgs = "--load-media-component-extension=1";
      })
      # discordo
      # docker
      # docker-client
      # docker-compose
      # logisim-evolution
      # osu-lazer-bin
      protonvpn-gui
      qemu
      teams-for-linux
      virt-manager
      wine
    ];

    home-manager.users.yuma = _: {
      home.username = "yuma";
      home.homeDirectory = "/home/yuma";
      home.stateVersion = "23.05";
      wayland.windowManager.hyprland.settings.monitor = [
        "eDP-1, prefered, auto, 1"
      ];
    };

    # Enable TLP (better than gnomes internal power manager)
    services.tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };

    # Disable GNOMEs power management
    services.power-profiles-daemon.enable = false;

    # Enable powertop
    powerManagement.powertop.enable = true;

    # Enable thermald (only necessary if on Intel CPUs)
    services.thermald.enable = true;

    systemd.services.home-manager-yuma.environment.HOME = "/home/yuma";

    home-manager.verbose = false;

    virtualisation.kvmgt.enable = true;
    virtualisation.libvirtd.enable = true;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/05953257-79bf-4a5b-938e-760a1c033d80";
      fsType = "ext4";
    };

    fileSystems."/boot/efi" = {
      device = "/dev/disk/by-uuid/CAF8-8EC8";
      fsType = "vfat";
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/fe6892c3-09c2-4cf5-abe0-71cea4090d52";}
    ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
