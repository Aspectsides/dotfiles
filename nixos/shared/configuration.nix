{ inputs, config, lib, pkgs, ... }:

{

  console.keyMap = "us";

  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [ zsh ];

    systemPackages = lib.attrValues {
      inherit (pkgs)
        alsa-tools alsa-utils cmake coreutils curl fd ffmpeg fzf gcc git glib
        gnumake gnutls home-manager imagemagick iw libtool lm_sensors man-pages
        man-pages-posix pamixer psmisc pulseaudio ripgrep unrar unzip vim
        wget wirelesstools xarchiver xclip zip;
    };

    variables = {
      EDITOR = "${pkgs.vim}/bin/vim";
      "_JAVA_OPTIONS" = "-Dawt.useSystemAAFontSettings=lcd";
      "_JAVA_AWT_WM_NONREPARENTING" = "1";
    };
  };

  fonts = {
    fonts = lib.attrValues {
      inherit (pkgs)
        cantarell-fonts
        emacs-all-the-icons-fonts
        liberation_ttf
        noto-fonts-emoji-blob-bin
        sarasa-gothic;

      nerdfonts = pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; };
    };

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "Sarasa Term K" ];
        monospace = [ "CaskaydiaCove Nerd Font Mono" ];
        emoji = [ "Blobmoji" ];
      };
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://cache.ngi0.nixos.org/"
        "https://nix-community.cachix.org"
        "https://fortuneteller2k.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
      ];
    };
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        openssl
        curl
        glib
        util-linux
        glibc
        icu
        libunwind
        libuuid
        zlib
        libsecret
      ];
    };

    npm = {
      enable = true;
      npmrc = ''
        prefix = ''${HOME}/.npm
        color = true
      '';
    };

    java = {
      enable = true;
      package = pkgs.jre;
    };

    zsh.enable = true;
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "America/Los_Angeles";
  };

  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;

    users.javacafe01 = {
      description = "Daniel Xu";
      isNormalUser = true;
      home = "/home/aspect";

      extraGroups =
        [ "wheel" "networkmanager" "sudo" "video" "audio" "adbusers" ];
    };
  };
}
