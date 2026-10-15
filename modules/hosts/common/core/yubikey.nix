{...}: {
  flake.nixosModules.yubikey = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [yubikey-manager];

    programs.yubikey-touch-detector.enable = true;
    services.pcscd.enable = true;

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
