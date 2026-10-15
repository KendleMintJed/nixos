{self, ...}: {
  flake.nixosModules.core = {
    pkgs,
    system,
    host,
    ...
  }: {
    imports = with self.nixosModules; [
      # users
      kendle

      # system
      fonts
      locale
      audio
      xdg
      yubikey
      stylix

      # applications
      nvf
      bat
      lazygit
      concord
    ];

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      download-buffer-size = 524288000;
    };

    networking = {
      hostName = host;
      networkmanager.enable = true;
    };

    boot.initrd.systemd.enable = true;

    environment.systemPackages =
      (with self.packages.${system}; [
        git
        yazi
        delta
      ])
      ++ (with pkgs; [
        devenv
        ripgrep
        fd
        dust
        tldr
        eza
        wget
      ]);

    system.stateVersion = "25.05";
  };
}
