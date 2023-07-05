{ config, ... }:

let theme = config.colorScheme;
in
{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = {
          x = 20;
          y = 20;
        };

        dynamic_padding = true;
        decorations_theme_variant = "Dark";
      };

      font = {
        size = 12;
        builtin_box_drawing = true;
      };

      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };

      colors = with theme.colors; {
        primary = {
          background = "0x${base00}";
          foreground = "0x${base06}";
        };

        cursor = { cursor = "0x${base07}"; };

        normal = {
          black = "0x${base01}";
          red = "0x${base08}";
          green = "0x${base0B}";
          yellow = "0x${base0A}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          cyan = "0x${base0C}";
          white = "0x${base06}";
        };

        bright = {
          black = "0x${base02}";
          red = "0x${base08}";
          green = "0x${base0B}";
          yellow = "0x${base0A}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          cyan = "0x${base0C}";
          white = "0x${base07}";
        };
      };
    };
  };
}
