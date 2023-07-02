{ pkgs
, lib
, inputs
, config
, ...
}: {
  gtk = {
    enable = true;
    font.name = "Fira Sans";
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur-dark";
    };
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
  };
  # gtk 4 themes suck
  xdg.configFile."gtk-4.0" = {
    source = ../../configs/gtk-4.0;
    recursive = true;
  };
  home.sessionVariables = {
    GTK_THEME = "Dracula";
    #   GTK_CSD = "0";
    #   LD_PRELOAD = "${config.nur.repos.dukzcry.gtk3-nocsd}/lib/libgtk3-nocsd.so.0";
  };
}
