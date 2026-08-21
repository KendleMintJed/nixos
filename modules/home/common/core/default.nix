{self, ...}: {
  flake.homeModules.core = {...}: {
    imports = with self.homeModules; [
      zsh
    ];
  };
}
