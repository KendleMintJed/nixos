{...}: {
  flake.nixosModules.inputRemapper = {...}: {
    services.input-remapper = {
      enable = true;
      enableUdevRules = true;
    };
  };
}
