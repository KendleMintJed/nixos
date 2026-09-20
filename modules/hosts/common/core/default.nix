{self, ...}: {
  flake.nixosModules.core = {
    pkgs,
    system,
    host,
    ...
  }: {
    imports = with self.nixosModules; [
      kendle
      xdg
      stylix
      nvf
      bat
      lazygit
    ];

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      download-buffer-size = 524288000;
    };

    networking = {
      hostName = host;
      networkmanager.enable = true;
    };

    environment.systemPackages =
      (with self.packages.${system}; [
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
      ]);

    fonts = {
      packages = with pkgs; [
        noto-fonts
        nerd-fonts.jetbrains-mono
        twitter-color-emoji
        self.packages.${system}.twemoji-color-font
      ];
      fontconfig.defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["JetBrainsMono Nerd Font"];
        emoji = ["Twitter Color Emoji"];
      };
    };

    time.timeZone = "Europe/London";

    i18n = {
      defaultLocale = "en_GB.UTF-8";

      extraLocaleSettings = {
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
    };

    services.xserver.xkb.layout = "gb";
    console.keyMap = "uk";

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    system.stateVersion = "25.05";
  };
}
