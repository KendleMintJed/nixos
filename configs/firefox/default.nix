{self, ...}: {
  flake.configs.firefox = {
    pkgs,
    lib,
    system,
    ...
  }:
    with self.configs.firefoxModules; {
      enable = true;
      settings = settings {};

      globalExtensions = extensions {inherit system;};

      profiles.default = profile {inherit pkgs lib;};
    };
}
