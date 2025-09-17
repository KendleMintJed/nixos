{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;

  services.upower.enable = true;

  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-hyprland];

  environment.systemPackages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
