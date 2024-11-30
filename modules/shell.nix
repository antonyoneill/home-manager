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
        fpath+=(~/.config/zsh/pure)
        export PURE_PROMPT_SYMBOL=$
        autoload -U promptinit; promptinit
        prompt pure
      '';

      #      zplug = {
      #        enable = true;
      #        plugins = [
      #          {
      #            name = "dracula/zsh";
      #            tags = [as:theme];
      #          }
      #        ];
      #      };
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "direnv" "wd"];
      };
    };
    home.file.".config/zsh/zsh.d".source = ./zsh/zsh.d;
    home.file.".config/zsh/zsh.d".recursive = true;
    home.file.".config/zsh/pure".source = fetchGit {
      url = "https://github.com/sindresorhus/pure.git";
      rev = "a02209d36c8509c0e62f44324127632999c9c0cf";
    };
  };
}
