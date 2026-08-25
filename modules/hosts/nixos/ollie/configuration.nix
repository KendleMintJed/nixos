{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.ollieConfig = {...}: {
    imports = with self.nixosModules; [
      inputs.nixos-hardware.nixosModules.dell-precision-5560

      ollieHardware
      core
      grub
      sddm
      niri
    ];

    # boot.extraModprobeConfig = ''
    #  options xe force_probe=9a60
    #  options i915 force_probe=!9a60
    # '';

    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 32 * 1024;
      }
    ];

    boot.initrd.systemd.enable = true;
    services.logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
    systemd.sleep.settings.Sleep = {
      HibernateDelaySec = "1h";
      SuspendState = "mem";
    };

    nixpkgs.config.allowUnfree = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware = {
      nvidia = {
        modesetting.enable = true;
        open = false;
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
      bluetooth = {
        enable = true;
        powerOnBoot =
          true;
      };
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services.printing.enable = true;

    security.rtkit.enable = true;

    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    programs.git.enable = true;

    programs.yubikey-touch-detector.enable = true;

    programs.ssh.startAgent = false;
    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
