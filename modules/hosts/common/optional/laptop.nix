{...}: {
  flake.nixosModules.laptop = {...}: {
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
}
