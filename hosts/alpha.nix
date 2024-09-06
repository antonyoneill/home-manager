{
  pkgs,
  lib,
  ...
}: {
  programs.git.signing.signByDefault = false;
}
