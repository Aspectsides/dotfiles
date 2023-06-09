{ config
, pkgs
, inputs
, lib
, ...
}:
let
  dependencies = with pkgs;
    [
      kickoff
      brightnessctl
      pamixer
      coreutils
    ];
  theme = config.colorScheme;
  ewwYuck = pkgs.writeText "eww.yuck" (
    ''
      (defwidget bar []
        (centerbox :orientation "v"
                   :halign "center"
          (box :class "segment-top"
               :valign "start"
               :orientation "v"
            (tags))
          (box :class "segment-center"
               :valign "center"
               :orientation "v"
            (time)
            (date))
          (box :class "segment-bottom"
               :valign "end"
               :orientation "v"
            (menu)
            (brightness)
            (volume)
            (battery)
            (current-tag))))

      (defwidget time []
        (box :class "time"
             :orientation "v"
          hour min sec))

      (defwidget date []
        (box :class "date"
             :orientation "v"
          day month year))

      (defwidget menu []
        (button :class "icon"
                :orientation "v"
                :onclick "''${EWW_CMD} open --toggle notifications-menu"
           "󰍜"))

      (defwidget brightness []
        (button :class "icon"
                :orientation "v"
          (circular-progress :value brightness-level
                             :thickness 3)))

      (defwidget volume []
        (button :class "icon"
                :orientation "v"
          (circular-progress :value volume-level
                             :thickness 3)))

      (defwidget battery []
        (button :class "icon"
                :orientation "v"
                :onclick ""
          (circular-progress :value "''${EWW_BATTERY['macsmc-battery'].capacity}"
                             :thickness 3)))

      (defwidget current-tag []
        (button :class "current-tag"
                :orientation "v"
                :onclick "kickoff & disown"
          "''${active-tag}"))

      (defvar active-tag "1")
      (defpoll hour :interval "1m" "date +%H")
      (defpoll min  :interval "1m" "date +%M")
      (defpoll sec  :interval "1s" "date +%S")

      (defpoll day   :interval "10m" "date +%d")
      (defpoll month :interval "1h"  "date +%m")
      (defpoll year  :interval "1h"  "date +%y")

      (defvar brightness-level 66)
      (defvar volume-level 33)
      (deflisten battery-level
         `cat /sys/class/power_supply/macsmc-battery/capacity`)

        (defwidget tags []
          (box :class "tags"
               :orientation "v"
               :halign "center"
            (for tag in tags
              (box :class {active-tag == tag.tag ? "active" : "inactive"}
                (button :onclick "swaymsg workspace ''${tag.tag} ; ''${EWW_CMD} update active-tag=''${tag.tag}"
                  "''${tag.label}")))))

        (defvar tags '[{ "tag": 1, "label": "一" },
                       { "tag": 2, "label": "二" },
                       { "tag": 3, "label": "三" },
                       { "tag": 4, "label": "四" },
                       { "tag": 5, "label": "五" },
                       { "tag": 6, "label": "六" },
                       { "tag": 7, "label": "七" },
                       { "tag": 8, "label": "八" },
                       { "tag": 9, "label": "九" },
                       { "tag": 0, "label": "rM" }]')

      (defwindow bar
        :monitor 0
        :stacking "fg"
        :geometry (geometry
                    :x 0
                    :y 0
                    :height "100%"
                    :anchor "left center")
        :exclusive true
        (bar))

      (defwindow bar2
        :monitor 1
        :stacking "fg"
        :geometry (geometry
                    :x 0
                    :y 0
                    :height "100%"
                    :anchor "left center")
        :exclusive true
        (bar))
    ''
  );

  ewwScss = pkgs.writeText "eww.scss" (with theme.colors; ''
    $base00: #${base00};
    $base01: #${base01};
    $base02: #${base02};
    $base03: #${base03};
    $base04: #${base04};
    $base05: #${base05};
    $base06: #${base06};
    $base07: #${base07};
    $base08: #${base08};
    $base09: #${base09};
    $base0A: #${base0A};
    $base0B: #${base0B};
    $base0C: #${base0C};
    $base0D: #${base0D};
    $base0E: #${base0E};
    $base0F: #${base0F};

    * {
      all: unset;
    }

    window {
      font-family: "monospace";
      font-size: 16px;
      background: $base00;
      color: $base04;
      & > * {
        margin: 0px 12px 12px;
      }
    }

    .tags {
      margin-top: 9px;
    }

    .active {
      color: $base06;
      background-color: $base01;
      padding: 6px 9px 6px 6px;
      border-left: 3px solid $base0C;
    }

    .segment-center {
      background-color: $base01;
      padding: 9px;
      border-radius: 3px;
    }

    .time {
      color: $base06;
      font-weight: bold;
      margin-bottom: 6px;
    }

    .date {
      margin-top: 6px;
    }

    .icon {
      background-color: $base01;
      padding: 9px 9px;
      margin-bottom: 9px;
      border-radius: 3px;
    }

    .current-tag {
      color: $base00;
      background-color: $base0B;
      padding: 9px 0px 9px;
      border-radius: 3px;
    }
  '');

  ewwConf = pkgs.linkFarm "ewwConf" [
    {
      name = "eww.scss";
      path = ewwScss;
    }
    {
      name = "eww.yuck";
      path = ewwYuck;
    }
  ];
in
{
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ewwConf;
  };
  systemd.user.services.eww = {
    Unit = {
      Description = "Eww daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
      ExecStart = "${config.programs.eww.package}/bin/eww daemon --no-daemonize";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
