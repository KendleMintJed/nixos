{...}: {
  flake.nixosModules.bat = {...}: {
    programs.bat = {
      enable = true;
      settings.theme = "Catppuccin Mocha";
    };
  };
}
