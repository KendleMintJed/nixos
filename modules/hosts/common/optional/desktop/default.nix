{self, ...}: {
  flake.nixosModules.desktop = {
    pkgs,
    system,
    lib,
    config,
    ...
  }: {
    options.optionals.desktop = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      defaultApps.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };

    imports = with self.nixosModules; [
      sddm
      niri
    ];

    config = lib.mkIf config.optionals.desktop.enable {
      nixpkgs.config.allowUnfree = lib.mkIf config.optionals.desktop.defaultApps.enable true;
      environment.systemPackages = lib.mkIf config.optionals.desktop.defaultApps.enable (with pkgs; [
        self.packages.${system}.ghostty

        wl-clipboard
        mpv
        yubioath-flutter
        keepassxc
        proton-vpn
        qbittorrent
        nicotine-plus
        obsidian
        # anki # disabled due to build error
        heroic
      ]);

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
      services.printing.enable = true;
    };
  };
}
