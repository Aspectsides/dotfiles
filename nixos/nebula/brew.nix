{
  homebrew = {
    enable = true;
    caskArgs.require_sha = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = let
      skipSha = name: {
        inherit name;
        args = {require_sha = false;};
      };
      noQuarantine = name: {
        inherit name;
        args = {no_quarantine = true;};
      };
    in [
      "alfred"
      "bitwarden"
      "blender"
      "discord"
      "docker"
      "firefox"
      "iina"
      "imageoptim"
      "karabiner-elements"
      "obs"
      "postman"
      "rustdesk"
      "uninstallpkg"
      "utm"
      (noQuarantine "easy-move-plus-resize")
      (noQuarantine "eloston-chromium")
      (skipSha "element")
      (skipSha "sizzy")
      (noQuarantine "vial")
    ];
    taps = ["homebrew/cask" "homebrew/cask-drivers"];
  };
}