{inputs, ...}: {
  flake.homeModules.catppuccin = {...}: {
    imports = [inputs.catppuccin.homeModules.catppuccin];
    catppuccin = {
      enable = true;
      autoEnable = false;
      flavor = "mocha";
      accent = "blue";

      qt5ct.enable = true;
    };
  };
}
