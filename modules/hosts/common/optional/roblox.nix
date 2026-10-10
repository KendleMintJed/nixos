{inputs, ...}: {
  flake.nixosModules.roblox = {...}: {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

    services.flatpak = {
      enable = true;
      packages = ["org.vinegarhq.Sober"];
    };
  };
}
