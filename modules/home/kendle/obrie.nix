{self, ...}: {
  flake.homeModules.obrie = {...}: {
    imports = with self.homeModules; [
      core
      optionals
    ];

    optionals.media.autoEnable = true;
  };
}
