{self, ...}: {
  flake.nixosModules.media = {lib, ...}: {
    options.optionals.media = {
      autoEnable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    imports = with self.nixosModules; [
      affinity
      concord
      must
      septabee
    ];
  };
}
