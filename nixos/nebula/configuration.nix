{
  imports = [
    ./brew.nix
    ./darwin
  ];

  networking.computerName = "nebula";
  system.stateVersion = 4;
  security.pam.enableSudoTouchIdAuth = true;
  networking.hostName = "nebula";
}