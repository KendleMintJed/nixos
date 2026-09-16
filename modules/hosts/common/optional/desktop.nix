{self, ...}: {
  flake.nixosModules.desktop = {
    pkgs,
    system,
    ...
  }: {
    imports = with self.nixosModules; [
      grub
      sddm
      niri
      septabee
      steam
    ];

    environment.systemPackages = with pkgs; [
      self.packages.${system}.ghostty
      proton-vpn
      anki
    ];
  };
}
