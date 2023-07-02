{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory $git_branch$git_status$nix_shell\n$character";
      directory = {
        format = "[ $path ](bg:#383838)";
        truncate_to_repo = false;        
      };
      character = {
        success_symbol = "[](bold blue)";
        error_symbol = "[](bold red)";
      };
      nix_shell.symbol = "[](bold blue) ";
      command_timeout = 1000;
    };
  };
}
