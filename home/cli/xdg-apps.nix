{ pkgs
, lib
, inputs
, config
, ...
}: {
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "image/png" = ["org.xfce.ristretto.desktop"];
      "image/jpeg" = ["org.xfce.ristretto.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/chrome" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "application/x-extension-htm" = ["firefox.desktop"];
      "application/x-extension-html" = ["firefox.desktop"];
      "application/x-extension-shtml" = ["firefox.desktop"];
      "application/xhtml+xml" =  ["firefox.desktop"];
      "application/x-extension-xhtml" = ["firefox.desktop"];
      "application/x-extension-xhtm" = ["firefox.desktop"];
    };
    defaultApplications = {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "image/png" = ["org.xfce.ristretto.desktop"];
      "image/jpeg" = ["org.xfce.ristretto.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/chrome" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "application/x-extension-htm" = ["firefox.desktop"];
      "application/x-extension-html" = ["firefox.desktop"];
      "application/x-extension-shtml" = ["firefox.desktop"];
      "application/xhtml+xml" =  ["firefox.desktop"];
      "application/x-extension-xhtml" = ["firefox.desktop"];
      "application/x-extension-xhtm" = ["firefox.desktop"];
    };
  };
}
