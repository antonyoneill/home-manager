{
  config,
  lib,
  ...
}: {
  imports = [
    ./git.nix
    ./nixvim.nix
    ./shell.nix
  ];
}
