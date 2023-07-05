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

    (import ../shared/programs/alacritty { inherit config; })
    (import ../shared/services/picom { inherit config; })
    (import ../shared/programs/bat { inherit config; })
    (import ../shared/programs/direnv { inherit config; })
    (import ../shared/programs/exa { inherit config; })
    (import ../shared/programs/sway { inherit config inputs lib pkgs; })
    (import ../shared/programs/lf { inherit config inputs lib pkgs; })
    (import ../shared/programs/eww { inherit config inputs lib pkgs; })
    (import ../shared/programs/rofi { inherit config inputs lib pkgs; })
    (import ../shared/programs/tmux { inherit config inputs lib pkgs; })
    (import ../shared/programs/music { inherit config inputs lib pkgs; })
    (import ../shared/programs/zoxide { inherit config inputs lib pkgs; })
    (import ../shared/programs/dunst { inherit config inputs lib pkgs; })
    (import ../shared/services/kanshi.nix { inherit config inputs lib pkgs; })

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
      inputs.nixpkgs-f2k.overlays.stdenvs
      inputs.nur.overlay

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })

      (final: prev:
        {
          neovim = inputs.neovim-nightly.packages.${final.system}.default;
          ripgrep = prev.ripgrep.override { withPCRE2 = true; };
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

  gtk = {
    enable = true;
    font.name = "sans-serif";

    gtk3 = {
      extraConfig = { gtk-decoration-layout = "menu:"; };

      extraCss = ''
        vte-terminal {
          padding: 20px;
        }
      '';
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "tomorrow-night";
      package = (inputs.nix-colors.lib-contrib { inherit pkgs; }).gtkThemeFromScheme {
        scheme = config.colorScheme;
      };
    };
  };

  home = {
    activation = {
      installAwesomeConfig = ''
        if [ ! -d "${config.home.homeDirectory}/.config/awesome" ]; then
          ln -s "/etc/nixos/config/awesome" "${config.home.homeDirectory}/.config/awesome" 
        fi
      '';
      installNvimConfig = ''
        if [ ! -d "${config.home.homeDirectory}/.config/nvim" ]; then
          ln -s "/etc/nixos/config/nvim" "${config.home.homeDirectory}/.config/nvim" 
        fi
      '';
    };

    file = {
      # Amazing Phinger Icons
      ".icons/default".source =
        "${pkgs.phinger-cursors}/share/icons/phinger-cursors";

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

      ".local/bin/appmenu" = {
        # Preview script for fzf tab
        executable = true;
        text = import ../shared/bin/appmenu.nix { inherit pkgs; };
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

    homeDirectory = "/home/aspect";

    packages = lib.attrValues {
      inherit (pkgs)
        neovim
        playerctl
        trash-cli
        xdg-user-dirs
        file
        any-nix-shell
        xst

        # Formatters
        black
        ktlint
        nixpkgs-fmt
        rustfmt
        shfmt
        stylua

        psst
        zotero
        komikku
        webcord
        calibre
        srain
        paper-icon-theme
        vscode
        font-manager
        transmission-gtk

        # Extras
        fd
        gnutls
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
      XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    username = "aspect";
  };

  programs = {
    home-manager.enable = true;
    mpv.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    playerctld.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  xdg = {
    enable = true;

    configFile = {
      "nvim/parser/c.so".source =
        "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
      "nvim/parser/lua.so".source =
        "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
      "nvim/parser/rust.so".source =
        "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
      "nvim/parser/python.so".source =
        "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
      "nvim/parser/nix.so".source =
        "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
    };

    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/Documents";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
    };
  };
  xresources.extraConfig = import ../shared/x/resources.nix { theme = config.colorScheme; };
}
