{...}: {
  flake.nixosModules.laptop = {
    lib,
    config,
    ...
  }: {
    options.optionals.hardware.laptop = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config = lib.mkIf config.optionals.hardware.laptop.enable {
      services.upower.enable = true;
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      services.logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
      systemd.sleep.settings.Sleep = {
        HibernateDelaySec = "1h";
        SuspendState = "mem";
      };
    };
  };
}
