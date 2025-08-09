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
    ./password-store.nix
    ./stylix.nix
  ];

  programs.keepassxc.enable = true;

  services.nextcloud-client.enable = true;

  programs.bat.enable = true;

  home.packages = with pkgs; [
    inputs.rcheck.outputs.packages.x86_64-linux.default

    eza
    fd
    fselect
    ripgrep
    dust
    dua
    tldr
    nix-index
    vesktop
    tor-browser
    fluffychat
  ];
}
