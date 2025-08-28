{pkgs, ...}: {
  imports = [
    ./git.nix
    ./nvf.nix
    ./zsh.nix
    ./lazygit.nix
    ./pay-respects.nix
    ./password-store.nix
    ./stylix.nix
  ];

  programs.home-manager.enable = true;

  home.username = "kendle";
  home.homeDirectory = "/home/kendle";

  programs.bat.enable = true;

  home.packages = with pkgs; [
    eza
    fd
    fselect
    ripgrep
    dust
    dua
    tldr
    nix-index
  ];

  home.stateVersion = "24.11";
}
