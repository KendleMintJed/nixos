{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = lib.flatten [
    ./xdg.nix
    ./stylix.nix

    (map lib.custom.relativeToRoot [
      "hosts/common/users/kendle.nix"
    ])
  ];

  _module.args = {
    pkgs-stable = import inputs.nixpkgs-stable {system = pkgs.stdenv.hostPlatform.system;};
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    download-buffer-size = 524288000;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [inputs.nix-vscode-extensions.overlays.default];
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  console.keyMap = "uk";

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  system.stateVersion = "25.05";
}
