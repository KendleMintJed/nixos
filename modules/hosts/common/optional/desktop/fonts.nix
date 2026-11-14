{self, ...}: {
  flake.nixosModules.fonts = {
    pkgs,
    system,
    lib,
    config,
    ...
  }: {
    options.optionals.desktop.fonts = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.desktop.enable;
      };
    };

    config.fonts = lib.mkIf config.optionals.desktop.fonts.enable {
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
  };
}
