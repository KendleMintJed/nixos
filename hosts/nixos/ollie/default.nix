{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    ./hardware-configuration.nix

    (map lib.custom.relativeToRoot [
      "hosts/common/core"
    ])
  ];

  networking = {
    hostName = "ollie";
    networkmanager.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];

  services.xserver = {
    enable = true;

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    xkb = {
      layout = "gb";
      variant = "";
    };
  };

  console.keyMap = "uk";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.kendle = {
    isNormalUser = true;
    description = "kendle";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "kendle" = import (lib.custom.relativeToRoot "home/kendle/ollie.nix");
    };
  };

  programs.git.enable = true;

  programs.yubikey-touch-detector.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.ssh.startAgent = false;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    mullvad-browser
    yubioath-flutter
    yubikey-manager
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
