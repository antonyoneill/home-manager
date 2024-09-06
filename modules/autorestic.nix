{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.my.autorestic;
in {
  options.modules.my.autorestic = {
    enable = mkOption {
      default = false;
      description = ''
        Enable autorestic scheduled task
      '';
    };
    location = mkOption {
      description = ''
        Location of autorestic configuration
      '';
    };
    runAsRoot = mkOption {
      default = false;
      description = ''
        Whether it needs to run with priviledges
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.autorestic = {
      Unit.Description = "Autorestic scheduled service for ${cfg.location} runs as root: ${toString cfg.runAsRoot}";
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.autorestic}/bin/autorestic -c ${cfg.location} --ci cron";
      };
      Install.WantedBy = ["default.target"];
    };
    systemd.user.timers.autorestic = {
      Unit.Description = "Autorestic scheduled job for ${cfg.location} runs as root: ${toString cfg.runAsRoot}";
      Timer = {
        Unit = "autorestic";
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
