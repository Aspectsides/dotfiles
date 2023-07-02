{ pkgs
, lib
, inputs
, config
, ...
}: {
  home.packages = with pkgs;
    [
      pinentry
    ];
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
    settings = {
      pinentry-program = "${pkgs.pinentry}/bin/pinentry";
    };
  };
}
