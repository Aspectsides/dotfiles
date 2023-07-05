{ config, pkgs, package, extensions, ... }:

{
  programs.firefox = {
    enable = true;
    inherit package;

    profiles = {
      myprofile = {
        inherit extensions;
        id = 0;

        settings = {
          "browser.startup.homepage" = "https://aspectsides.site/startpage/";
          "general.smoothScroll" = true;
        };

        userChrome = import ./userChrome-css.nix {
          theme = config.colorScheme;
        };

        userContent = import ./userContent-css.nix {
          theme = config.colorScheme;
        };

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
          user_pref("extensions.pocket.enabled", false);
        '';
      };
    };
  };
}
