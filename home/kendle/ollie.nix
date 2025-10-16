{...}: {
  imports = [
    ./common/core
    ./common/optional/gtk.nix
    ./common/optional/firefox.nix
    ./common/optional/nixcord.nix
    ./common/optional/wezterm.nix
    ./common/optional/hyprland
    ./common/optional/vscode
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-5,preferred,0x0,1"
      "DP-4,preferred,1920x0,1"
      "eDP-1,preferred,3840x0,1"
    ];
    workspace = [
      "1, monitor:DP-5"
      "2, monitor:DP-4, default:true"
      "3, monitor:eDP-1"
    ];
  };

  home.file = {
  };

  home.sessionVariables = {
  };

  home.stateVersion = "24.11";
}
