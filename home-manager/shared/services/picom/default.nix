{ config, ... }:

{
  services.picom = {
    enable = true;
    backend = "xrender";
  };
}
