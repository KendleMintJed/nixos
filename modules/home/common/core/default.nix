{self, ...}: {
  flake.homeModules.core = {...}: {
    imports = with self.homeModules; [
      zsh
      gtk
    ];
    home.stateVersion = "24.11";
  };
}
