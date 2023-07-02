{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.git = {
    enable = true;
    userName = "aspectsides";
    userEmail = "heavydenial@proton.me";
    delta.enable = true;
    ignores = [ "**/.idea/" "**/.vscode/settings.json" "**/.direnv/" "**/.DS_Store" ];
    extraConfig = {
      pull = { ff = "only"; };
      init.defaultBranch = "main";
    };
  };
}
