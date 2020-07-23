{ config, pkgs, lib, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    #various
    pip faker pywal black setuptools wheel twine flake8 virtualenv pudb
    # console
    aioconsole
    #server
    aiohttp
    #isn
    pygame pillow
    #ntru
    sympy numpy docopt
    #database
    psycopg2
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
  {
    imports = [ ./i3.nix ./polybar.nix ./rofi.nix ./alacritty.nix ./compton.nix ];
    nixpkgs.config.allowUnfree = true;

    home.keyboard.layout = "fr";
    home.packages = with pkgs; [
      # TERMINAL
      gotop htop neofetch cava zip unrar unzip xorg.xev escrotum tree gnupg
      aria2 imagemagick feh httpie
      # DEVELOPMENT
      (callPackage ./termius.nix { }) vscodium idea.idea-ultimate 
      python-with-my-packages conda zulu8 gradle rustup gcc m4 gnumake binutils
      # BLOCKCHAIN
      ledger-live-desktop
      # OFFICE
      texlive.combined.scheme-medium wpsoffice typora brave
      # DEFAULT
      kotatogram-desktop discord vlc spotify gimp blueman wineWowPackages.stable
      # GAMES
      bastet multimc tigervnc
    ];

    programs = {
      home-manager.enable = true;
      command-not-found.enable = true;
      git = {
        enable = true;
        userName = "Thomas Marchand";
        userEmail = "thomas.marchand" + "@" + "tuta.io";
      };
    };

    xsession.enable = true;
  }
