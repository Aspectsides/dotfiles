{ pkgs
, lib
, inputs
, config
, ...
}: {
  gtk = {
    enable = true;
    font = {
      name = "Fira Sans";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };
  };
  home.sessionVariables = {
    GTK_THEME = "Colloid-Dark";
    #   GTK_CSD = "0";
    #   LD_PRELOAD = "${config.nur.repos.dukzcry.gtk3-nocsd}/lib/libgtk3-nocsd.so.0";
  };
}
