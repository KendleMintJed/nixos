{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.obrieConfig = {...}: {
    imports = with self.nixosModules; [
      inputs.nixos-hardware.nixosModules.dell-latitude-9510

      obrieHardware
      core

      laptop
      desktop

      must
    ];
  };
}
