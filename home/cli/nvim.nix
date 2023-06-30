{ pkgs
, lib
, inputs
, config
, ...
}: {
  xdg.configFile."nvim" = {
    source = ../../configs/nvim;
    recursive = true;
  };
}
