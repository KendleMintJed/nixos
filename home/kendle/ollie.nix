{...}: {
  imports = [
    ./common/core
    ./common/optional/gtk.nix
    ./common/optional/firefox.nix
    ./common/optional/nixcord.nix
    ./common/optional/wezterm.nix
    ./common/optional/hyprland
  ];

  wayland.windowManager.hyprland.settings.monitor = [
    "DP-4,preferred,0x0,1"
    "DP-5,preferred,2560x0,1"
    "eDP-1,preferred,5120x0,1"
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  home.stateVersion = "24.11";
}
