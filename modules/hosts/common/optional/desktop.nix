{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    imports = with self.nixosModules; [
      grub
      sddm
      niri
      septabee
    ];

    environment.systemPackages = with pkgs; [
      proton-vpn
      anki
    ];
  };
}
