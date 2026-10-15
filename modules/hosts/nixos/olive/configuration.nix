{self, ...}: {
  flake.nixosModules.oliveConfig = {
    system,
    modulesPath,
    pkgs,
    ...
  }: {
    imports = with self.nixosModules; [
      (modulesPath + "/virtualisation/proxmox-lxc.nix")

      oliveHardware
      core
    ];

    nix.settings.sandbox = false;

    proxmoxLXC = {
      manageNetwork = false;
      privileged = true;
    };

    # Supress systemd units that don't work because of LXC
    systemd.suppressedSystemUnits = [
      "dev-mqueue.mount"
      "sys-kernel-debug.mount"
      "sys-fs-fuse-connections.mount"
    ];

    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    environment.systemPackages = [
      self.packages.${system}.ghostty
      pkgs.yubikey-manager
    ];

    virtualisation.docker.enable = true;

    programs.yubikey-touch-detector.enable = true;

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
