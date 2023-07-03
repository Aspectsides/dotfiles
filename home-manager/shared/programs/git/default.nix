{ config, lib, pkgs, ... }:

{
  programs.gh = {
    enable = true;

    extensions = lib.attrValues {
      inherit (pkgs)
        gh-cal
        gh-dash
        gh-eco;
    };

    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      editor = "${pkgs.neovim}/bin/nvim";
    };
  };

  programs.git = {
    enable = true;
    userName = "Daniel Xu";
    userEmail = "heavydenial@proton.me";
  };
}
