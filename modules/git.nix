{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.my.git;
in {
  options.modules.my.git = {
    enable = mkOption {
      default = false;
      description = ''
        Enable Git and Github packages
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Antony O'Neill";
      userEmail = mkDefault "antony@ant-web.co.uk";
      signing = {
        key = "49293F327888CC24F7C8FD652DFFAD3B0C45D8A4";
        signByDefault = mkDefault true;
      };
      ignores = [
        ".idea"
      ];
      aliases = {
        branch-name = "!git rev-parse --abbrev-ref HEAD";
        ci = "commit -v";
        cif = "!git ci --fixup";
        cia = "!git ci --amend";
        ciane = "!git cia --no-edit";
        co = "checkout";
        evclone = "!f() { git clone git@github.com:eeveebank/$1; }; f";
        git = "!git";
        initpls = "!git init && git ci -m 'Root Commit' --allow-empty";
        lol = "log --decorate --oneline --graph";
        lola = "log --all --decorate --oneline --graph";
        ppr = "!git rbm && git publish && git prlazy";
        ppro = "!git ppr && gh pr view --web";
        prlazy = "!gh pr create --fill";
        publish = "!git push -u origin $(git branch-name)";
        rbd = "!git fetch origin && git rebase origin/development && echo 'now git push'";
        rbm = "!git fetch origin && git rebase origin/master && echo 'now git push'";
        rbmp = "!git fetch origin && git rebase origin/master && git push";
        recover-rejected-commit = "!git ci -e --file=$(git rev-parse --git-dir)/COMMIT_EDITMSG";
        st = "status";
      };
    };

    programs.gh = {
      enable = true;
    };
  };
}
