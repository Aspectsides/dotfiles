# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    asahi-alsa-utils = prev.alsa-utils.override {
      alsa-lib = prev.alsa-lib.override {
        alsa-ucm-conf = prev.alsa-ucm-conf.overrideAttrs (_: rec {
          asahi-alsa-src = prev.fetchFromGitHub {
            owner = "AsahiLinux";
            repo = "alsa-ucm-conf-asahi";
            rev = "461b4fe8853fc876c6b2f92414efa9d63f6aa213";
            sha256 = "sha256-BacaisE38uA5Gf5rHiYC2FRY29kJ1THBQ861wo5HJYI=";
          };

          installPhase = ''
            runHook preInstall
            mkdir -p $out/share/alsa
            cp -r ucm ucm2 $out/share/alsa
            cp -r ${asahi-alsa-src}/ucm2/conf.d/macaudio $out/share/alsa/ucm2/conf.d/macaudio
            runHook postInstall
          '';
        });
      };
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
