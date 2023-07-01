{ pkgs
, lib
, inputs
, config
, isWayland
, ...
}: 

let 
  run = import ./run.nix { inherit pkgs; };
  preview = import ./preview.nix { inherit pkgs; };
in

{
  imports = [
    ./bat.nix
    ./cava.nix
    ./zsh.nix
    ./music.nix
    ./lf.nix
    ./nvim.nix
    ./exa.nix
    ./fish.nix
    ./git.nix
    ./starship.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs;
    [
      # coreutils
      uutils-coreutils
      # grep
      (ripgrep.override {
        withPCRE2 = true;
      })
      # rm
      rip
      unzip
      spotdl
      ranger
      pkgs.autotiling-rs
      run # my own script :D
      preview # my own script :D
      direnv
      mutt-wizard
      gnupg
      cmake
      gnumake
      git-crypt
      shellcheck
      chafa
      jq
      elinks
      glow
      fd
      nodejs
      atool
      exiftool
      binutils-unwrapped
      trash-cli
      fzf
      cached-nix-shell
      neovim-nightly
    ]
    ++ lib.optionals isWayland [
      wl-clipboard
    ];
}
