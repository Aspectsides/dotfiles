{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.chromium = {
    enable = true;
  };
  programs.chromium.extensions = [
    { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
    { id = "nngceckbapebfimnlniiiahkandclblb"; }
    { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
    { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
    { id = "hipekcciheckooncpjeljhnekcoolahp"; }
  ];
}
