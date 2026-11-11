{...}: {
  flake.nixosModules.nh = {...}: {
    programs.nh = {
      enable = true;
      flake = "/home/kendle/nixos";
    };
  };
}
