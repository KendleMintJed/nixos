{inputs, ...}: {
  perSystem = {
    pkgs,
    self',
    lib,
    ...
  }: {
    packages.git = inputs.wrapper-modules.wrappers.git.wrap {
      inherit pkgs;
      settings = let
        delta = lib.getExe self'.packages.delta;
      in {
        init.defaultBranch = "main";
        commit.gpgsign = true;
        user = {
          useConfigOnly = true;

          name = "KendleMintJed";
          email = "KendleMintJed@proton.me";
          signingkey = "0C0AE68B63FA8F1757B97F9E31BB390EC1A9FAB5";
        };

        core.pager = delta;
        interactive.diffFilter = "${delta} --color-only";
        merge.conflictStyle = "zdiff3";
      };
    };
  };
}
