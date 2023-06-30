{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.nushell = {
    enable = true;
    configFile = { text = ''
      let-env config = {
        show_banner: false
       }
     ''; 
    };
    envFile.text = ''
      mkdir ~/.cache/starship
      starship init nu | save -f ~/.cache/starship/init.nu
    '';
    extraConfig = ''
      source ~/.cache/starship/init.nu
    '';
  };
}
