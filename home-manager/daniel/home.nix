# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }:

{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.discocss.hmModule
    inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    (import ../shared/programs/bat { inherit config; })
    (import ../shared/programs/direnv { inherit config; })
    (import ../shared/programs/exa { inherit config; })
    (import ../shared/programs/tmux { inherit config inputs lib pkgs; })
    (import ../shared/programs/music { inherit config inputs lib pkgs; })
    (import ../shared/programs/zoxide { inherit config inputs lib pkgs; })

    (import ../shared/programs/firefox {
      inherit config pkgs;
      package = pkgs.firefox;

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
        octotree
      ];
    })

    (import ../shared/programs/git { inherit config lib pkgs; })
    (import ../shared/programs/starship { inherit config; })

    (import ../shared/programs/zsh { inherit config pkgs inputs lib; colorIt = false; })
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.modifications
      outputs.overlays.additions

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      inputs.nur.overlay

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })

      (final: prev:
        {
          # picom = inputs.nixpkgs-f2k.packages.${pkgs.system}.picom-git;
        })
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes.tomorrow-night;

  fonts.fontconfig.enable = true;

  home = {
    activation = {
      installNvimConfig = ''
        if [ ! -d "${config.home.homeDirectory}/.config/nvim" ]; then
          ln -s "/etc/nixos/config/nvim" "${config.home.homeDirectory}/.config/nvim" 
        fi
      '';
    };

    file = {
      ".local/bin/run" = {
        # Preview script for fzf tab
        executable = true;
        text = import ../shared/bin/run.nix { inherit pkgs; };
      };

      ".local/bin/preview" = {
        # Preview script for fzf tab
        executable = true;
        text = import ../shared/bin/preview.nix { inherit pkgs; };
      };

      ".tree-sitter".source = pkgs.runCommand "grammars" { } ''
        mkdir -p $out/bin
        ${
          lib.concatStringsSep "\n" (lib.mapAttrsToList (name: src:
            "name=${name}; ln -s ${src}/parser $out/bin/\${name#tree-sitter-}.so")
            pkgs.tree-sitter.builtGrammars)
        };
      '';
    };

    homeDirectory = "/Users/daniel";

    packages = lib.attrValues {
      inherit (pkgs)
        neovim
        trash-cli
        file
        any-nix-shell

        # Formatters
        black
        ktlint
        nixpkgs-fmt
        rustfmt
        shfmt
        stylua

        # Extras
        fd
        imagemagick
        chafa
        jq
        elinks
        glow
        fzf
        cached-nix-shell
        exiftool
        sdcv
        sqlite
        statix
        ripgrep;
    };

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    sessionVariables = {
      BROWSER = "${pkgs.firefox}/bin/firefox";
      EDITOR = "${pkgs.neovim}/bin/nvim";
      RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    username = "daniel";
  };

  programs = {
    home-manager.enable = true;
  };

  services = {

  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

}
