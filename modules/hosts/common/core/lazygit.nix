{...}: {
  flake.nixosModules.lazygit = {
    pkgs,
    lib,
    ...
  }: {
    programs.lazygit = {
      enable = true;
      settings.git = {
        diffRenderers = [
          {
            colorArg = "always";
            command = "${lib.getExe pkgs.delta} --paging=never --syntax-theme=\"Catppuccin Mocha\"";
          }
        ];
        overrideGpg = true;
      };
    };
  };
}
