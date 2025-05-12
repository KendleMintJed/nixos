{pkgs, ...}: {
  imports = [
    ./git.nix
    ./nvf.nix
    ./zsh.nix
    ./firefox.nix
    ./kitty.nix
    ./lazygit.nix
    ./pay-respects.nix
    ./hyprland
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
