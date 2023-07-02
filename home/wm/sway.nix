{ pkgs
, lib
, inputs
, config
, ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway-hidpi;
    systemdIntegration = true;
    extraSessionCommands = ''
      export XDG_CURRENT_DESKTOP=sway;
    '';
    wrapperFeatures.gtk = true;
    config = {
      startup = [
        {
          command = "${pkgs.eww-wayland-git}/bin/eww open bar && ${pkgs.eww-wayland-git}/bin/eww open bar2";
          always = false;
        }
        {
          command = "${pkgs.pamixer}/bin/pamixer --set-volume 33";
          always = false;
        }
        {
          command = "${pkgs.emacs-pgtk}/bin/emacs --daemon &";
          always = false;
        }
        {
          command = "${pkgs.autotiling-rs}/bin/autotiling-rs";
          always = false;
        }
        {
          command = "${pkgs.brightnessctl}/bin/brightnessctl s 66%";
          always = false;
        }
      ];
      window = {
        titlebar = true;
        border = 0;
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_options = "caps:escape";
        };
        "type:mouse" = {
          dwt = "disabled";
          accel_profile = "flat";
        };
        "type:touchpad" = {
          tap = "enabled";
          accel_profile = "adaptive";
          scroll_factor = "0.45";
          pointer_accel = "0.27";
        };
      };
      # output = {
      #   "*" = {
      #     background = "#${config.lib.base16.theme.baseDARK-hex} solid_color";
      #   };
      # };
      bars = lib.mkForce [ ];
      gaps.outer = 7;
      gaps.inner = 7;
      defaultWorkspace = "workspace 1";
      keybindings =
        let
          modifier = "Mod4";
          concatAttrs = lib.fold (x: y: x // y) { };
          tagBinds =
            concatAttrs
              (map
                (i: {
                  "${modifier}+${toString i}" = "exec 'swaymsg workspace ${toString i} && ${pkgs.eww-wayland-git}/bin/eww update active-tag=${toString i}'";
                  "${modifier}+Shift+${toString i}" = "exec 'swaymsg move container to workspace ${toString i}'";
                })
                (lib.range 0 9));
        in
        tagBinds
        // {
          "${modifier}+Return" = "exec ${pkgs.foot}/bin/foot";
          "${modifier}+e" = "exec ${pkgs.emacs-pgtk}/bin/emacsclient -c -a 'emacs'";
          "${modifier}+d" = "exec appmenu";
          "${modifier}+p" = "exec ${pkgs.screenshot}/bin/screenshot";
          # "${modifier}+Shift+p" = "exec ${pkgs.ocrScript}/bin/wl-ocr";
          "${modifier}+Shift+p" = "exec ${pkgs.grim}/bin/grim -o eDP-1";
          "XF86AudioLowerVolume" = "exec ${pkgs.volume}/bin/volume -d 5";
          "XF86AudioRaiseVolume" = "exec ${pkgs.volume}/bin/volume -i 5";
          "${modifier}+Shift+v" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "${modifier}+Shift+b" = "exec ${pkgs.volume}/bin/volume -t";
          "XF86MonBrightnessDown" = "exec ${pkgs.brightness}/bin/brightness set 5%-";
          "XF86MonBrightnessUp" = "exec ${pkgs.brightness}/bin/brightness set 5%+";
          "${modifier}+Shift+n" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "${modifier}+Shift+m" = "exec ${pkgs.playerctl}/bin/playerctl next";

          "${modifier}+q" = "kill";
          "${modifier}+r" = ''mode "resize"'';
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+f" = "fullscreen";
          "${modifier}+space" = "floating toggle";
          "${modifier}+Shift+s" = "sticky toggle";
          "${modifier}+Shift+space" = "focus mode_toggle";
          "${modifier}+a" = "focus parent";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+e" = "exit";
        };
      colors = with config.lib.base16.theme; {
        focused = {
          background = "#${base0C-hex}";
          indicator = "#${base0C-hex}";
          border = "#${base0C-hex}";
          text = "#${base0C-hex}";
          childBorder = "#${base0C-hex}";
        };
        focusedInactive = {
          background = "#${base01-hex}";
          indicator = "#${base01-hex}";
          border = "#${base01-hex}";
          text = "#${base01-hex}";
          childBorder = "#${base01-hex}";
        };
        unfocused = {
          background = "#${base01-hex}";
          indicator = "#${base01-hex}";
          border = "#${base01-hex}";
          text = "#${base01-hex}";
          childBorder = "#${base01-hex}";
        };
        urgent = {
          background = "#${base0A-hex}";
          indicator = "#${base0A-hex}";
          border = "#${base0A-hex}";
          text = "#${base0A-hex}";
          childBorder = "#${base0A-hex}";
        };
      };
    };
    extraConfig = ''

      # Remove text on decorations
      # for_window [title="."] title_format " "
      # font pango:monospace 18px 
      # default_border normal 0
      # default_floating_border normal 0
      default_border pixel 2
      default_floating_border pixel 2
      smart_borders on


      # swayfx
      # shadows on
      # shadow_blur_radius 27
      # corner_radius 3

      # gestures
      bindgesture swipe:3:right workspace prev
      bindgesture swipe:3:left workspace next
      bindgesture swipe:3:up exec ${pkgs.sov}/bin/sov

      input * repeat_delay 180
      input * repeat_rate 50

      # start a headless vnc session for headless display
      output * scale 1.5

      # bind workspaces 1-9 to main output
      workspace 1 output eDP-1
      workspace 2 output eDP-1
      workspace 3 output eDP-1
      workspace 4 output eDP-1
      workspace 5 output eDP-1
      workspace 6 output eDP-1
      workspace 7 output eDP-1
      workspace 8 output eDP-1
      workspace 9 output eDP-1

      # workspace 0 can be headless
      workspace 0 output HEADLESS-1
    '';
  };
  services.kanshi.systemdTarget = "sway-session.target";
}
