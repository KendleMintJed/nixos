{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.ollie = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      host = "ollie";
      system = "x86_64-linux";
    };
    modules = [
      self.nixosModules.ollieConfig
    ];
  };
}
