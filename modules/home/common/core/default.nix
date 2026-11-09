{self, ...}: {
  flake.homeModules.core = {...}: {
    imports = with self.homeModules; [
      zsh
      gtk
      catppuccin
    ];
    home.stateVersion = "24.11";
  };
}
