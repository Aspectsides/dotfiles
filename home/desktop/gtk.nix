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
      package = pkgs.gruvbox-dark-icons-gtk;
      name = "gruvbox-dark-icons-gtk";
    };
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
  };
  home.sessionVariables = {
    GTK_THEME = "Dracula";
    #   GTK_CSD = "0";
    #   LD_PRELOAD = "${config.nur.repos.dukzcry.gtk3-nocsd}/lib/libgtk3-nocsd.so.0";
  };
}
