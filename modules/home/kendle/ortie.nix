{self, ...}: {
  flake.homeModules.ortie = {...}: {
    imports = with self.homeModules; [
      core
      optionals
    ];

    optionals.media.autoEnable = true;
  };
}
