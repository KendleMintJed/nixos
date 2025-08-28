{
  pkgs,
  inputs,
  lib,
  host,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  programs.zsh.enable = true;

  users.users.kendle = {
    isNormalUser = true;
    description = "kendle";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhrWTP9t0gt51CbKh3iuzg0KBHB819+s6qgdgc35xLC openpgp:0xE0DB7A03"];
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users = {
      "kendle" = import (lib.custom.relativeToRoot "home/kendle/${host}.nix");
    };
  };
}
