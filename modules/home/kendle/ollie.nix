{self, ...}: {
  flake.homeModules.ollie = {...}: {
    imports = with self.homeModules; [
      core
      optionals
    ];

    optionals.media.autoEnable = true;
  };
}
