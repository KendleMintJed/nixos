{pkgs, ...}: {
  programs.lazygit = {
    enable = true;
    settings.git = {
      pagers = [
        {
          colorArg = "always";
          pager = "${pkgs.delta}/bin/delta --paging=never";
        }
      ];
      overrideGpg = true;
    };
  };
}
