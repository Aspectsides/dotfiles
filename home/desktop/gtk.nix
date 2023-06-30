{ pkgs
, lib
, inputs
, config
, ...
}: {
  gtk = {
    enable = true;
    font.name = "Liga SFMono Nerd Font";
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur-dark";
    };
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };
  # gtk 4 themes suck
  xdg.configFile."gtk-4.0" = {
    source = ../../configs/gtk-4.0;
    recursive = true;
  };
  home.sessionVariables = {
    GTK_THEME = "Nordic";
    #   GTK_CSD = "0";
    #   LD_PRELOAD = "${config.nur.repos.dukzcry.gtk3-nocsd}/lib/libgtk3-nocsd.so.0";
  };
}
