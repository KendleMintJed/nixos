{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.obrie = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      host = "obrie";
      system = "x86_64-linux";
    };
    modules = [
      self.nixosModules.obrieConfig
    ];
  };
}
