{ config, ...}:

let theme = config.colorScheme;
in
{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "monospace:size=12";
        pad = "27x27";
        dpi-aware = "no";
        # notify = "${pkgs.libnotify}/bin/notify-send -a foot -i foot \${title} \${body}";
        # line-height = "25px";
        # vertical-letter-offset = "3px";
      };

      mouse.hide-when-typing = "yes";
      scrollback.lines = 32768;
      # url.launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
      tweak.grapheme-shaping = "yes";
      cursor.style = "beam";
      colors = with theme.colors; {
        background = "${base00}";
        foreground = "${base06}";
        regular0 = "${base00}";
        regular1 = "${base0B}";
        regular2 = "${base0C}";
        regular3 = "${base0D}";
        regular4 = "${base07}";
        regular5 = "${base0F}";
        regular6 = "${base09}";
        regular7 = "${base04}";
        bright0 = "${base03}";
        bright1 = "${base0B}";
        bright2 = "${base0C}";
        bright3 = "${base0D}";
        bright4 = "${base07}";
        bright5 = "${base0F}";
        bright6 = "${base09}";
        bright7 = "${base06}";
      };
    };
  };
}
