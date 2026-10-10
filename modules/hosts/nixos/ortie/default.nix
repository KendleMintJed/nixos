{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.ortie = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      host = "ortie";
      system = "x86_64-linux";
    };
    modules = [
      self.nixosModules.ortieConfig
    ];
  };
}
