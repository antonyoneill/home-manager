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

  home.username = specialArgs.username;
  home.homeDirectory = specialArgs.homeDir + "/" + specialArgs.username;

  home.packages = [
  ];

  home.file = {
  };

  modules.my = {
    shell.enable = true;
    nixvim.enable = true;
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
  };

  # Do not change below
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
