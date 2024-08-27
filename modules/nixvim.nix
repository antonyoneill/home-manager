{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.my.nixvim;
in {
  options.modules.my.nixvim = {
    enable = mkOption {
      default = false;
      description = ''
        Enable Nix Vim
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      vimAlias = true;

      extraPackages = with pkgs; [alejandra];
      extraPlugins = [pkgs.vimPlugins.gruvbox];
      colorschemes.gruvbox.enable = true;
      plugins.lightline.enable = true;
      plugins.conform-nvim = {
        enable = true;
        formattersByFt = {
          nix = ["alejandra"];
        };
        formatOnSave = {};
      };

      opts = {
        expandtab = true;
        shiftwidth = 2;
        smartindent = true;
        tabstop = 2;
      };
    };
  };
}
