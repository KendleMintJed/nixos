{inputs, ...}: {
  flake.nixosModules.catppuccin = {...}: {
    imports = [inputs.catppuccin.nixosModules.catppuccin];
    catppuccin = {
      enable = true;
      autoEnable = false;
      flavor = "mocha";
      accent = "blue";

      tty.enable = true;
    };
  };
}
