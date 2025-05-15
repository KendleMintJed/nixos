{pkgs, ...}: {
  imports = [
    ./git.nix
    ./nvf.nix
    ./zsh.nix
    ./firefox.nix
    ./wezterm.nix
    ./lazygit.nix
    ./pay-respects.nix
    ./hyprland
    ./gtk.nix
    ./qt.nix
  ];

  programs.keepassxc.enable = true;

  services.nextcloud-client.enable = true;

  home.packages = with pkgs; [
    bat
    eza
    fd
    ripgrep
    dust
    tldr
    nix-index
  ];
}
