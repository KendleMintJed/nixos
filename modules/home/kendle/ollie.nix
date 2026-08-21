{self, ...}: {
  flake.homeModules.kendle = {...}: {
    imports = with self.homeModules; [
      core

      firefox
      nixcord
    ];
    home.stateVersion = "24.11";
  };
}
