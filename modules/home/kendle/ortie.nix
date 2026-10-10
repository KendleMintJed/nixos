{self, ...}: {
  flake.homeModules.ortie = {...}: {
    imports = with self.homeModules; [
      core

      firefox
      nixcord
    ];
    home.stateVersion = "24.11";
  };
}
