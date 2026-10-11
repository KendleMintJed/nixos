{...}: {
  flake.nixosModules.logitech = {pkgs, ...}: {
    hardware.logitech.enable = true;
    services.ratbagd.enable = true;
    environment.systemPackages = with pkgs; [piper];
  };
}
