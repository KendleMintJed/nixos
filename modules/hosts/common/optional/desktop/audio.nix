{...}: {
  flake.nixosModules.audio = {
    lib,
    config,
    ...
  }: {
    options.optionals.desktop.audio = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.desktop.enable;
      };
    };

    config = lib.mkIf config.optionals.desktop.audio.enable {
      services.pipewire = {
        enable = true;
        audio.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      security.rtkit.enable = true;
    };
  };
}
