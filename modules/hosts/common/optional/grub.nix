{...}: {
  flake.nixosModules.grub = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.optionals.grub = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      useOSProber = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config.boot.loader = lib.mkIf config.optionals.grub.enable {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = config.optionals.grub.useOSProber;

        theme = pkgs.stdenv.mkDerivation {
          pname = "distro-grub-themes";
          version = "3.1";
          src = pkgs.fetchFromGitHub {
            owner = "AdisonCavani";
            repo = "distro-grub-themes";
            rev = "v3.1";
            hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
          };
          installPhase = "cp -r customize/nixos $out";
        };
      };
    };
  };
}
