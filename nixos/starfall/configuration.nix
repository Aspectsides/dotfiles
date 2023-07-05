{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    # auto generated
    ./hardware-configuration.nix
    ../shared/configuration.nix
    inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  # overlay
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.modifications
      outputs.overlays.additions
      inputs.nixos-apple-silicon.overlays.apple-silicon-overlay

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
      inputs.nixpkgs-f2k.overlays.stdenvs

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })

      (_: prev:
        {
          awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
        })
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  services = {
    # greetd = {
    #   enable = true;
    #   package = pkgs.greetd.tuigreet;
    #   settings = {
    #     default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --cmd sway";
    #   };
    # };
    xserver = {
      enable = true;

      displayManager = {
        autoLogin = {
          enable = true;
          user = "aspect";
        };

        defaultSession = "none+awesome";

        lightdm = {
          enable = true;
          greeters.gtk.enable = true;
        };
      };

      dpi = 141;

      libinput = {
        enable = true;
        touchpad = { naturalScrolling = true; };
      };

      windowManager = {
        awesome = {
          enable = true;

          luaModules = lib.attrValues {
            inherit (pkgs.luajitPackages) lgi ldbus luadbi-mysql luaposix;
          };
        };
      };
    };
  };

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      acpi
      brightnessctl
      inotify-tools
      libnotify
      pavucontrol
      pciutils
      skippy-xd
      mesa-asahi-edge
      xlockmore;

    inherit (pkgs.xfce)
      orage
      ristretto
      xfce4-appfinder
      xfce4-clipman-plugin
      xfce4-screenshooter
      xfce4-taskmanager
      xfce4-terminal;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;

    nm-applet = {
      enable = true;
      indicator = false;
    };

    thunar = {
      enable = true;

      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };

    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.xlockmore}/bin/xlock -mode dclock";
    };
  };

  # new kernel
  hardware.asahi.addEdgeKernelConfig = true;

  # apple firmware
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # enable graphics acceleration
  hardware.asahi.useExperimentalGPUDriver = true;
  hardware.asahi.experimentalGPUInstallMode = "driver";

  # environment.variables = {
  #   MESA_GL_VERSION_OVERRIDE = "3.3";
  #   MESA_GLES_VERSION_OVERRIDE = "3.1";
  #   MESA_GLSL_VERSION_OVERRIDE = "330";
  # };

  # swap fn and control key
  boot.kernelParams = [
    "hid_apple.swap_fn_leftctrl=1"
  ];

  # use systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "starfall";
  system.stateVersion = "23.05";
}
