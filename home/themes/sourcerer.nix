{ config
, inputs
, ...
}: {
  config = {
    themes.base16 = {
      enable = true;
      path = "${inputs.base16-sourcerer}/sourcerer.yaml";
    };
  };
}
