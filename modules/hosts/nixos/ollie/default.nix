{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.ollie = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {host = "ollie";};
    modules = [
      self.nixosModules.ollieConfig
    ];
  };
}
