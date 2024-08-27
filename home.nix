{
  config,
  pkgs,
  specialArgs,
  lib,
  ...
}: rec {
  imports = [
    ./modules
  ];

  home.username = "antony";
  home.homeDirectory = specialArgs.homeDir + "/antony";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
  ];

  home.file = {
  };

  modules.my = {
    shell.enable = true;
    nixvim.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
