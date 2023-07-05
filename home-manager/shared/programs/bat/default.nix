{ config, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      pager = "never";
      style = "plain";
      theme = "base16";
    };
  };
}
