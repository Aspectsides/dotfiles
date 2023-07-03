{ pkgs
, lib
, inputs
, ...
}: {
  imports = [
    # auto generated
    ./hardware-configuration.nix
    inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  # overlay
  nixpkgs.overlays = [ inputs.nixos-apple-silicon.overlays.apple-silicon-overlay ];

  # new kernel
  hardware.asahi.addEdgeKernelConfig = true;

  # apple firmware
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # enable graphics acceleration
  hardware.asahi.useExperimentalGPUDriver = true;
  hardware.asahi.experimentalGPUInstallMode = "driver";

  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 85;
    };
  };

  # swap fn and control key
  boot.kernelParams = [
    "hid_apple.swap_fn_leftctrl=1"
  ];


  # fix headphones hack
  environment.systemPackages = [ pkgs.asahi-alsa-utils ];
  systemd.user.services.fix-asahi-jack = {
    script = ''
      ${pkgs.asahi-alsa-utils}/bin/amixer -c 0 set 'Jack Mixer' 100%
    '';
    wantedBy = [ "default.target" ];
  };

  # use systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "starfall";
  system.stateVersion = "23.05";
}
