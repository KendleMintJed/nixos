{...}: {
  flake.nixosModules.nvidia = {
    lib,
    config,
    ...
  }: {
    options.optionals.hardware.nvidia = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      laptop = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.hardware.laptop.enable;
      };
      package = lib.mkOption {
        type = with lib.types; (nullOr package);
        default = null;
      };
    };

    config = lib.mkIf config.optionals.hardware.nvidia.enable {
      services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        prime = lib.mkIf config.optionals.hardware.nvidia.laptop {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
        package = with config.optionals.hardware.nvidia; (lib.mkIf (package != null) package);
      };
    };
  };
}
