{ config, ... }:

{
  programs.starship = {
    enable = true;
    settings = import ./settings.nix;
  };
}

