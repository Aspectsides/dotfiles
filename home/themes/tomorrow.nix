{ config
, inputs
, ...
}: {
  config = {
    themes.base16 = {
      enable = true;
      path = "${inputs.base16-schemes}/tomorrow-night.yaml";
    };
  };
}
