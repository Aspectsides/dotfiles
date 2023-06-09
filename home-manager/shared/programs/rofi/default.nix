{ pkgs
, lib
, inputs
, config
, ...
}:
let theme = config.colorScheme;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  xdg.configFile."rofi/config.rasi".text = with theme.colors; ''
   configuration {
     icon-theme:       "Paper";
     cycle:            true;
     disable-history:  false;
     monitor:          "-4";

     /* Vim-esque C-j/C-k as up/down in rofi */
     kb-accept-entry: "Return,Control+m,KP_Enter";
     kb-row-down: "Down,Control+n,Control+j";
     kb-remove-to-eol: "";
     kb-row-up: "Up,Control+p,Control+k";
   }

   * {
     accent:   #${base0C};
     bg:       #${base00};
     bg-light: #${base01};
     bg-focus: #${base01};
     bg-dark:  #${base00};
     fg:       #${base05};
     fg-list:  #${base05};
     on:       #8BD49C;
     off:      #cc6666;

     magenta: #bd93f9;
     blue:    #${base0C};

     text-font:      "Fira Sans 15";
     text-mono-font: "Fira Code 13";
     /* icon-font:      "Hurmit Nerd Font Mono 26"; */
     icon-font:      "FontAwesome 20";

     background-color: transparent;
     text-color: @fg-list;
     font: @text-font;
     border-color: @bg-dark;
   }


   /**** Layout ****/
   window {
     width:    1000px;
     y-offset: -50px;
     anchor:   north;
     location: center;
     border: 1px;
     border-radius: 6px 6px 0 0;
     children: [ inputbar, listview ];

   }

   listview {
     lines: 12;
     fixed-height: false;
     /* reverse: true; */
     columns: 2;
     scrollbar: true;
     spacing: 1px;
     /* Remove strange gap between listview and inputbar */
     margin: -2px 0 0;
   }

   /*
     TODO Not supported in stable branch of rofi
     @media only (max-height: 1080px) {
       window {
         y-offset: -30%;
       }
       listview {
         lines: 14;
       }
     }
   */

   scrollbar {
     handle-width: 1px;
   }
   inputbar {
     children: [ textbox-icon, prompt, entry ];
     border: 0 0 0;
   }
   textbox-icon, prompt {
     padding: 11px;
     expand: false;
     border: 0 1px 0 0;
     margin: 0 -2px 0 0;
   }
   textbox-icon {
     padding: 7px 4px 0;
   }
   entry, element {
     padding: 10px 13px;
   }
   textbox {
     padding: 24px;
     margin: 20px;
   }


   /**** Looks ****/
   scrollbar {
     background-color: @bg-dark;
     handle-color: @accent;
     border-color: @bg-dark;
   }
   listview, inputbar {
     background-color: @bg-dark;
   }
   textbox-icon, prompt, entry {
     text-color: @accent;
   }
   prompt, entry {
     background-color: @bg-focus;
   }
   textbox-icon, prompt {
     background-color: @bg-light;
   }
   prompt {
     background-color: @bg-focus;
   }
   textbox-icon {
     font: @icon-font;
   }
   entry {
     font: @text-font-mono;
     text-color: @fg;
   }

   element {
     background-color: @bg;
     text-color: @fg;
   }
   element selected {
     background-color: @bg-dark;
     text-color: @accent;
   }
   '';
  xdg.configFile."rofi/appmenu.rasi".text = ''
    @import "config.rasi"

    textbox-icon {
      str: "  ";
    }

    prompt {
      enabled: false;
    }
   '';
}
