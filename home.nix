{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "antony";
  home.homeDirectory = "/home/antony";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/antony/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.direnv = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      for config (~/.config/zsh/zsh.d/*.zsh) source $config
    '';

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "direnv" "wd"];
    };
  };
  home.file.".config/zsh/zsh.d".source = ./files/zsh/zsh.d;
  home.file.".config/zsh/zsh.d".recursive = true;

  programs.nixvim = {
    enable = true;

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

  programs.git = {
    enable = true;
    userName = "Antony O'Neill";
    userEmail = "antony@ant-web.co.uk";
    signing = {
      key = "49293F327888CC24F7C8FD652DFFAD3B0C45D8A4";
      signByDefault = false;
    };
    aliases = {
      initpls = "!git init && git ci -m 'Root Commit' --allow-empty";
      co = "checkout";
      ci = "commit -v";
      ciane = "!git commit --amend --no-edit";
      st = "status";
      lola = "log --all --decorate --oneline --graph";
      recover-rejected-commit = "!git ci -e --file=$(git rev-parse --git-dir)/COMMIT_EDITMSG";
      # Get the current branch name (not so useful in itself, but used in
      # other aliases)
      branch-name = "!git rev-parse --abbrev-ref HEAD";
      # Push the current branch to the remote "origin", and set it to track
      # the upstream branch
      publish = "!git push -u origin $(git branch-name)";
      rbd = "!git reset --hard \"origin/$(git branch-name)\" && git fetch origin && git rebase origin/development && git push -f";
      rbm = "!git reset --hard \"origin/$(git branch-name)\" && git fetch origin && git rebase origin/master && git push -f";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
