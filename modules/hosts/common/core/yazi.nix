{inputs, ...}: {
  flake.nixosModules.yazi = {...}: {
    programs.yazi = {
      enable = true;
      settings.theme = fromTOML (builtins.readFile "${inputs.catppuccin-yazi}/themes/mocha/catppuccin-mocha-blue.toml");
    };
  };
}
