{self, ...}: {
  flake.nixosModules.core = {
    pkgs,
    host,
    ...
  }: {
    imports = with self.nixosModules; [
      xdg
      stylix
      nvf
      kendle
    ];

    environment.systemPackages = with pkgs; [
      devenv
    ];

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      download-buffer-size = 524288000;
    };

    networking = {
      hostName = host;
      networkmanager.enable = true;
    };

    time.timeZone = "Europe/London";

    i18n.defaultLocale = "en_GB.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };

    console.keyMap = "uk";

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    system.stateVersion = "25.05";
  };
}
