{self, ...}: {
  flake.homeModules.firefox = {
    pkgs,
    lib,
    system,
    ...
  }: {
    programs.librewolf = self.configs.firefox {inherit pkgs lib system;};

    home.file.stylus-storage = {
      source = "${self.packages.${system}.catppuccin-stylus}/storage.js";
      target = ".librewolf/default/browser-extension-data/{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}/storage.js";
    };
  };
}
