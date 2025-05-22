{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    ./hardware-configuration.nix

    {nixpkgs.overlays = [inputs.hyprpanel.overlay];}

    (map lib.custom.relativeToRoot [
      "hosts/common/core"
    ])
  ];

  networking = {
    hostName = "ollie";
    networkmanager.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

    };
  };

  services.printing.enable = true;

  security.rtkit.enable = true;

  users.users.kendle = {
    isNormalUser = true;
    description = "kendle";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users = {
      "kendle" = import (lib.custom.relativeToRoot "home/kendle/ollie.nix");
    };
  };

  programs.git.enable = true;

  programs.yubikey-touch-detector.enable = true;

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

  system.stateVersion = "25.05"; # Did you read the comment?
}
