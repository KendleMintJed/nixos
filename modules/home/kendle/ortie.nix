{self, ...}: {
  flake.homeModules.ortie = {...}: {
    imports = with self.homeModules; [
      core

      firefox
      nixcord
    ];
  };
}
