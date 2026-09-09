{inputs, ...}: {
  flake.nixosModules.septabee = {system, ...}: {
    imports = [inputs.septabee.nixosModules.${system}.default];

    environment.systemPackages = [inputs.septabee.packages.${system}.default];
  };
}
