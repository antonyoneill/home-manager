{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.sops
    pkgs.age
    pkgs.lastpass-cli
    pkgs.awscli2
  ];

  programs.spotify-player = {
    enable = true;
  };

  programs.git.signing.signByDefault = lib.mkForce true;
}
