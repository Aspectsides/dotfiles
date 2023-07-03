{
  character = {
    error_symbol = "[>>](bold red)";
    success_symbol = "[>>](bold cyan)";
    vicmd_symbol = "[>>](bold yellow)";
    format = "$symbol ";
  };

  format = "$all";
  add_newline = false;

  hostname = {
    ssh_only = true;
    format = "[$hostname](bold blue) ";
    disabled = false;
  };

  line_break.disabled = true;
  directory.disabled = true;
  nodejs.disabled = true;
  nix_shell.symbol = "[](blue) ";
  python.symbol = "[](blue) ";
  rust.symbol = "[](red) ";
  lua.symbol = "[](blue) ";
  package.symbol = "📦  ";
}
