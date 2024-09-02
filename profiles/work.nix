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

  modules.my.git = {
    enable = true;
  };

  programs.git.userEmail = "antony.oneill@mettle.co.uk";

  programs.ssh.includes = [
    "/Users/antony/.colima/ssh_config"
  ];

  programs.spotify-player = {
    enable = true;
  };
}
