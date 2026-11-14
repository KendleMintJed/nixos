{...}: {
  flake.nixosModules.nvidia = {
    lib,
    config,
    ...
  }: {
    options.optionals.nvidia = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      laptop = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.laptop.enable;
      };
      package = lib.mkOption {
        type = with lib.types; (nullOr package);
        default = null;
      };
    };

    config = lib.mkIf config.optionals.nvidia.enable {
      services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        prime = lib.mkIf config.optionals.nvidia.laptop {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
        package = with config.optionals.nvidia; (lib.mkIf (package != null) package);
      };
    };
  };
}
