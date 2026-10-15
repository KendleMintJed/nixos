{self, ...}: {
  flake.homeModules.olive = {...}: {
    imports = with self.homeModules; [
      core
    ];
    home.stateVersion = "24.11";
  };
}
