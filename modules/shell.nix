{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.my.shell;
in {
  options.modules.my.shell = {
    enable = mkOption {
      default = false;
      description = ''
        Enable zsh config and some other shell things
      '';
    };
  };
  config = mkIf cfg.enable {
    home.sessionVariables = {
      PATH = "$PATH:" + config.home.homeDirectory + "/bin";
    };

    programs.direnv = {
      enable = true;
    };

    programs.zsh = {
      enable = true;
      initExtra = ''
        for config (~/.config/zsh/zsh.d/*.zsh) source $config
      '';

      zplug = {
        enable = true;
        plugins = [
          {
            name = "dracula/zsh";
            tags = [as:theme];
          }
        ];
      };
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "direnv" "wd"];
      };
    };
    home.file.".config/zsh/zsh.d".source = ./zsh/zsh.d;
    home.file.".config/zsh/zsh.d".recursive = true;
  };
}
