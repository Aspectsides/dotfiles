{ config, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    shadow = false;
    shadowOffsets = [ (-10) (-10) ];
    shadowOpacity = 0.8;

    settings = {
      animations = true;
      #change animation speed of windows in current tag e.g open window in current tag
      animation-stiffness-in-tag = 125;
      #change animation speed of windows when tag changes
      animation-stiffness-tag-change = 90.0;
      animation-window-mass = 0.4;
      animation-dampening = 15;
      animation-clamping = true;
      #open windows
      animation-for-open-window = "zoom";
      #minimize or close windows
      animation-for-unmap-window = "squeeze";
      #popup windows
      animation-for-transient-window = "slide-up"; #available options: slide-up, slide-down, slide-left, slide-right, squeeze, squeeze-bottom, zoom
      #set animation for windows being transitioned out while changings tags
      animation-for-prev-tag = "minimize";
      #enables fading for windows being transitioned out while changings tags
      enable-fading-prev-tag = true;
      #set animation for windows being transitioned in while changings tags
      animation-for-next-tag = "slide-in-center";
      #enables fading for windows being transitioned in while changings tags
      enable-fading-next-tag = true;

      shadow-radius = 10;

      glx-no-stencil = true;
      glx-no-rebind-pixmap = true;
      unredir-if-possible = true;
    };
  };
}
