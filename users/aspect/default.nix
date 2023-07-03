{ pkgs
, lib
, inputs
, config
, ...
}: {
  users.users.aspect = {
    isNormalUser = true;
    home = "/home/aspect";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "render"
      "docker"
    ];
    shell = pkgs.zsh;
  };
}
