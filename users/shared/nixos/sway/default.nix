{ pkgs
, lib
, inputs
, config
, ...
}: {
  services = {
    greetd = {
      enable = true;
      package = pkgs.greetd.tuigreet;
      settings = {
        default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --cmd sway";
      };
    };
  };
}
