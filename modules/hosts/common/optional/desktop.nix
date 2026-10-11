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

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      self.packages.${system}.ghostty

      proton-vpn
      anki
      qbittorrent
      nicotine-plus
      obsidian
      wl-clipboard
      yubioath-flutter
      yubikey-manager
      heroic
    ];
  };
}
