{...}: {
  flake.nixosModules.steam = {...}: {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
