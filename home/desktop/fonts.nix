{ pkgs
, lib
, inputs
, config
, ...
}: 
{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "IBMPlexMono" "JetBrainsMono" "FiraCode" ]; })
    pkgs.fira-code
    pkgs.fira
    pkgs.recursive
    pkgs.roboto-mono
  ];
}