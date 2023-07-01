{ pkgs
, lib
, inputs
, config
, ...
}: {
services ={
  mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    dataDir = "${config.home.homeDirectory}/.config/mpd";
    extraConfig = ''
      auto_update           "yes"
      restore_paused        "yes"

      audio_output {
      	type                "pulse"
      	name                "pulse"
      	buffer_time         "100000"
      }

      bind_to_address "127.0.0.1"

      audio_output {
      	type                "fifo"
      	name                "Visualizer"
      	format              "44100:16:2"
      	path                "/tmp/mpd.fifo"
      }
    '';
    network.startWhenNeeded = true;
  };
    mpdris2 = {
      enable = true;
      mpd.host = "127.0.0.1";
    };
  };

  programs.beets = {
    enable = true;
    settings = {
      directory = "${config.home.homeDirectory}/Music";
      library = "${config.home.homeDirectory}/Music/musiclibrary.db";
    };
  };
  
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
      taglibSupport = true;
    };
    mpdMusicDir = "${config.home.homeDirectory}/Music";
    settings = {
      ncmpcpp_directory = "${config.xdg.configHome}/ncmpcpp";
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "Visualizer";
      visualizer_in_stereo   = true;
      visualizer_type        = "ellipse";
      visualizer_look        = "●●";
      visualizer_color       = "magenta, blue, cyan, green";
      external_editor                  = "nvim";
      message_delay_time               = 1;
      playlist_disable_highlight_delay = 2;
      autocenter_mode                  = true;
      centered_cursor                  = true;
      ignore_leading_the               = true;
      allow_for_physical_item_deletion = "no";
      lines_scrolled = "1";
      colors_enabled        = true;
      playlist_display_mode = "classic";
      user_interface        = "classic";
      volume_color          = "white";
      song_window_title_format = "Music";
      statusbar_visibility     = "no";
      header_visibility        = "no";
      titles_visibility        = "no";
      progressbar_look = "━━━";
      progressbar_color = "black";
      progressbar_elapsed_color = "yellow";
      song_status_format= "$7%t";
      song_list_format = "$(008)%t$R  $(247)%a$R$5  %l$8";
      song_columns_list_format = "(53)[blue]{tr} (45)[blue]{a}";
      current_item_prefix = "$b$2| ";
      current_item_suffix = "$/b$5";
      now_playing_prefix = "$b$5| ";
      now_playing_suffix = "$/b$5";
      song_library_format = "{{%a - %t} (%b)}|{%f}";
      main_window_color = "blue";
      current_item_inactive_column_prefix = "$b$5";
      current_item_inactive_column_suffix = "$/b$5";
      color1 = "white";
      color2 = "blue";
    };
    bindings = [
          { key = "j"; command = "scroll_down"; }
          { key = "k"; command = "scroll_up"; }
          { key = "l"; command = "enter_directory"; }
          { key = "l"; command = "play_item"; }
          { key = "h"; command = "jump_to_parent_directory"; }
      ];
  };
}
