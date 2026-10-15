{self, ...}: {
  flake.homeModules.olive = {...}: {
    imports = with self.homeModules; [
      core
    ];
  };
}
