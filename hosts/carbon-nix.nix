{
  pkgs,
  lib,
  ...
}: {
  programs.ssh.extraConfig = ''
    IdentityAgent ~/.1password/agent.sock
  '';
  home.packages = [pkgs.obsidian];
}
