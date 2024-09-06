{
  config,
  lib,
  ...
}: {
  imports = [
    ./autorestic.nix
    ./git.nix
    ./nixvim.nix
    ./shell.nix
  ];
}
