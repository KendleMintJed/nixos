{...}: {
  programs.git = {
    enable = true;

    delta.enable = true;

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      commit.gpgsign = true;
      user = {
        # Otherwise git will try to guess a default user identity. see `man git config`.
        useConfigOnly = true;

        name = "KendleMintJed";
        email = "KendleMintJed@proton.me";
        signingkey = "0C0AE68B63FA8F1757B97F9E31BB390EC1A9FAB5";
      };
    };
  };
}
