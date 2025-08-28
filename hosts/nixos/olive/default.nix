{
  lib,
  modulesPath,
  ...
}: {
  imports = lib.flatten [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ./hardware-configuration.nix

    (map lib.custom.relativeToRoot [
      "hosts/common/core"
      "hosts/common/users/kendle.nix"
    ])
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
}
