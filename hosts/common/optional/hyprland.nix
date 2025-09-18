{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;

  services.upower.enable = true;
  services.cloudflare-warp.enable = true;

  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-hyprland];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.systemPackages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
