{...}: {
  flake.nixosModules.logitech = {...}: {
    hardware.logitech.enable = true;
    programs.solaar.enable = true;
  };
}
