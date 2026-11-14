{inputs, ...}: {
  flake.configs.firefoxModules.extensions = {system, ...}:
    with inputs.firefox-addons.packages.${system}; [
      sponsorblock
      firefox-color
      stylus
    ];
}
