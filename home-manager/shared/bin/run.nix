{ pkgs }:

with pkgs;

''
  #> Syntax: bash
  command="$@"
  program=$(echo "$command" | awk '{print $1}')
  if [[ "$NIX_PKG" != "" ]]; then
    program="$NIX_PKG"
  fi
  cached-nix-shell -p "$program" --run "$command"
''
