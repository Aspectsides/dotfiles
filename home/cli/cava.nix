{ pkgs
, lib
, inputs
, config
, ...
}: {
  home.packages = with pkgs; [
    cava
  ];
  xdg.configFile."cava/config".text = with config.lib.base16.theme; ''
    [color]
    
    gradient = 1
    
    gradient_color_1 = '#${base03-hex}'
    gradient_color_2 = '#${base04-hex}'
    gradient_color_3 = '#${base05-hex}'
    gradient_color_4 = '#${base06-hex}'
    gradient_color_5 = '#${base07-hex}'
    gradient_color_6 = '#${base08-hex}'
    gradient_color_7 = '#${base09-hex}'
  '';
}
