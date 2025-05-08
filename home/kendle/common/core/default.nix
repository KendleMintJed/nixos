{pkgs, ...}: {
  imports = [
    ./git.nix
    ./nvf.nix
    ./zsh.nix
    ./firefox.nix
    ./kitty.nix
    ./lazygit.nix
    ./pay-respects.nix
  ];

  home.packages = with pkgs; [
    bat
    eza
    fd
    tldr
    nix-index
  ];
}
