{...}: {
  flake.nixosModules.logitech = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.optionals.logitech = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config = lib.mkIf config.optionals.logitech.enable {
      hardware.logitech.wireless.enable = true;
      services.ratbagd.enable = true;
      environment.systemPackages = with pkgs; [piper];
    };
  };
}
