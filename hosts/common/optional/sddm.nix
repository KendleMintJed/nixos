{
  pkgs,
  lib,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "JetBrainsMono Nerd Font";
      loginBackground = true;
      background = lib.custom.relativeToRoot "media/wallpaper.png";
    })
  ];
}
