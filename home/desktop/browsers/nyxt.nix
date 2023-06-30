{ pkgs
, lib
, inputs
, config
, ...
}: {
  home.packages = with pkgs; [
    nyxt
    mpv
    poppler_utils
  ] ++ (with pkgs.python3Packages; [
    grip
  ]);
  systemd.user.services.waylock-autolock = {
    Unit = {
      PartOf = [ "graphical-session.target" ];
      After = [ "network.target" ];
      Description = "Launch c backend for xterm";
    };
    Service = {
      ExecStart = ''
        ${pkgs.ttyd}/bin/ttyd -t rendererType=canvas -t 'theme={"background": "#161616", "foreground": "#ffffff", "cursor": "#f2f4f8", "black": "#161616", "red": "#78a9ff", "green": "#ff7eb6", "yellow": "#42be65", "blue": "#08bdba", "magenta": "#82cfff", "cyan": "#33b1ff", "white": "#f2f4f8", "brightBlack": "#c1c7cd", "brightRed": "#78a9ff", "brightGreen": "#ff7eb6", "brightYellow": "#42be65", "brightBlue": "#08bdba", "brightMagenta": "#82cfff", "brightCyan": "#33b1ff", "brightWhite": "#ffffff"}' -t disableLeaveAlert=true -t disableResizeOverlay=true  -t enableSixel=true -t fontSize=15 fish
      '';
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
