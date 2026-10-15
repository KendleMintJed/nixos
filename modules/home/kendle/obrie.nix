{self, ...}: {
  flake.homeModules.obrie = {...}: {
    imports = with self.homeModules; [
      core

      firefox
      nixcord
    ];
  };
}
