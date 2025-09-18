{...}: {
  imports = [
    ./common/core
    ./common/optional/gtk.nix
    ./common/optional/firefox.nix
    ./common/optional/nixcord.nix
    ./common/optional/wezterm.nix
    ./common/optional/hyprland
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  home.stateVersion = "24.11";
}
