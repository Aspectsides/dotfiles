{ pkgs
, lib
, inputs
, config
, ...
}: {
  environment.variables = {
    # defaults
    EDITOR = "emacsclient -c -a 'emacs'";
    # BROWSER = "firefox";

    # qt settings
    DISABLE_QT5_COMPAT = "0";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };
}
