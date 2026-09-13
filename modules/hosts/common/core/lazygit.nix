{self, ...}: {
  flake.nixosModules.lazygit = {
    lib,
    system,
    ...
  }: {
    programs.lazygit = {
      enable = true;
      settings.git = {
        diffRenderers = [
          {
            colorArg = "always";
            command = "${lib.getExe self.packages.${system}.delta} --paging=never";
          }
        ];
        overrideGpg = true;
      };
    };
  };
}
