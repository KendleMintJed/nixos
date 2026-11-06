{self, ...}: {
  flake.nixosModules.niri = {
    lib,
    system,
    ...
  }: {
    services.logind.settings.Login = {
      HandlePowerKey = lib.mkForce "ignore";
      HandlePowerKeyLongPress = lib.mkForce "ignore";
    };

    programs.niri = {
      enable = true;
      package = self.packages.${system}.niri;
    };

    programs.noctalia = {
      enable = true;
      package = self.packages.${system}.noctalia;
    };

    programs.xwayland.enable = true;
  };
}
