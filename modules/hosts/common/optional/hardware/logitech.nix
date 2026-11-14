{...}: {
  flake.nixosModules.logitech = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.optionals.hardware.logitech = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config = lib.mkIf config.optionals.hardware.logitech.enable {
      hardware.logitech.wireless.enable = true;
      services.ratbagd.enable = true;
      environment.systemPackages = with pkgs; [piper];
    };
  };
}
