{inputs, ...}: {
  flake.nixosModules.affinity = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.affinity.overlays.default];
    environment.systemPackages = with pkgs; [affinity-v3];
  };
}
