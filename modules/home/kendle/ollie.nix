{self, ...}: {
  flake.homeModules.ollie = {...}: {
    imports = with self.homeModules; [
      core

      firefox
      nixcord
    ];
    home.stateVersion = "24.11";
  };
}
