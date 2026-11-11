{self, ...}: {
  flake.homeModules.core = {...}: {
    imports = with self.homeModules; [
      zsh
      gtk
      qt
    ];
    home.stateVersion = "24.11";
  };
}
