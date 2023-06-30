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
      komikku
      calibre
      xfce.thunar
      emacs-pgtk
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
