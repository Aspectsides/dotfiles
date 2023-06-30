{ pkgs
, lib
, inputs
, config
, ...
}: {
  xdg.configFile."emacs" = {
    source = ../../../configs/emacs;
    recursive = true;
  };
}
