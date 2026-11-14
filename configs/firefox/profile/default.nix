{self, ...}: {
  flake.configs.firefoxModules.profile = {
    pkgs,
    lib,
    ...
  }:
    with self.configs.firefoxModules.profileModules; {
      search = search {inherit pkgs;};

      extensions = extensions {inherit lib;};

      userContent = userContent {};
    };
}
