{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.fish = {
    enable = true;
    shellAliases = with pkgs; {
      ":q" = "exit";
      git-rebase = "git rebase -i HEAD~2";
      ll = "${pkgs.exa}/bin/exa -lF --color-scale --no-user --no-time --no-permissions --group-directories-first --icons -a";
      ls = "${pkgs.exa}/bin/exa -lF --group-directories-first --icons -a";
      cp = "${pkgs.xcp}/bin/xcp";
      top = "${pkgs.bottom}/bin/btm";
      cat = "${pkgs.bat}/bin/bat --paging=never";
      v = "${pkgs.neovim-nightly}/bin/nvim --startuptime /tmp/nvim-startuptime";
      build = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-asahi-aarch64";
      gl = "git clone";
    };
    plugins = [
      {
        name = "fish-lf-icons";
        src = pkgs.fetchFromGitHub {
          owner = "joshmedeski";
          repo = "fish-lf-icons";
          rev = "d1c47b2088e0ffd95766b61d2455514274865b4f";
          sha256 = "6po/PYvq4t0K8Jq5/t5hXPLn80iyl3Ymx2Whme/20kc=";
        };
      }

      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "f9744199531d817b73650ec43decb0f86a04df75";
          sha256 = "vsx1LTaadZYKKjz3BQcm+0OjctMWYFVyWiH3WgUMgXw=";
        };
      }
    ];
    shellInit = ''
      set fish_greeting
    '';
  };
}
