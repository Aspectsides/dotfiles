{ pkgs
, lib
, inputs
, config
, isWayland
, ...
}: {
  imports = [
    ./discord.nix
    # ./obs-studio.nix
    ./zathura.nix
    # ./emacs.nix
  ];

  home.packages = with pkgs;
    [
      psst
      zotero
      gimp
      komikku
      calibre
      srain
      emacs-pgtk
      paper-icon-theme
      vscode
      cinnamon.nemo
      xfce.tumbler
      gnome.nautilus
      nextcloud-client
      font-manager
      xfce.ristretto
      transmission-gtk
    ]
    ++ lib.optionals isWayland [
      wayvnc
    ];
}
