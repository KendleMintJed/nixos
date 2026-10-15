{...}: {
  flake.nixosModules.fonts = {
    pkgs,
    system,
    ...
  }: {
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
  };
}
