{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.olive = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      host = "olive";
      system = "x86_64-linux";
    };
    modules = [
      self.nixosModules.oliveConfig
    ];
  };
}
