{
  pkgs,
  lib,
  ...
}: {
  programs.git.signing.signByDefault = false;

  modules.my.autorestic = {
    enable = true;
    runAsRoot = true;
    location = "/home/antony/docker-services/.autorestic.yaml";
  };
}
