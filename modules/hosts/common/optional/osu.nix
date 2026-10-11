{...}: {
  flake.nixosModules.osu = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [osu-lazer-bin];
  };
}
