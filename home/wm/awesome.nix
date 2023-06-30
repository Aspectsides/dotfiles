{ pkgs
, lib
, inputs
, config
, ...
}: {
  wayland.windowManager.awesome = {
    enable = true;
    package = awesome-git;
    xdg.configFile."awesome" = {
      source = ../../configs/awesome;
      recursive = true;
    };
  };
}
