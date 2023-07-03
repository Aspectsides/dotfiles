{ stdenv, src, version, ... }:

stdenv.mkDerivation {
  name = "SFMono-Nerd-Font-Ligaturized";
  inherit version;
  inherit src;
  dontConfigue = true;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -R $src/*.otf $out/share/fonts/opentype
  '';

  meta = { description = "Apple's SFMono font nerd-font patched and ligaturized "; };
}
