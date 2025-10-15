{
  pkgs,
  lib,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-blue";
    package = pkgs.kdePackages.sddm;
  };

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "blue";
      font = "JetBrainsMono Nerd Font";
      loginBackground = true;
      background = lib.custom.relativeToRoot "media/wallpaper.png";
    })
  ];
}
