{ pkgs
, lib
, inputs
, config
, ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  xdg.configFile."rofi" = {
    source = ../../configs/rofi;
    recursive = true;
  };
}
