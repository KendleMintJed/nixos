{inputs, ...}: {
  flake.nixosModules.septabee = {...}: {
    imports = [inputs.septabee.nixosModules.default];

    programs.septabee.enable = true;
  };
}
