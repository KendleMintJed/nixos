{
  pkgs,
  inputs,
  ...
}: {
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
    ./nix-colors.nix
    ./password-store.nix
  ];

  programs.keepassxc.enable = true;

  services.nextcloud-client.enable = true;

  home.packages = with pkgs; [
    inputs.rcheck.outputs.packages.x86_64-linux.default

    bat
    eza
    fd
    fselect
    ripgrep
    dust
    dua
    tldr
    nix-index
  ];
}
