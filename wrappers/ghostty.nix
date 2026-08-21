{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.ghostty = inputs.wrapper-modules.wrappers.ghostty.wrap {
      inherit pkgs;

      settings = {
        font-size = 16;
        font-family = "JetBrainsMono Nerd Font";
        theme = "Catppuccin Mocha";
        window-decoration = "none";
        background-opacity = 0.8;
        confirm-close-surface = false;
      };
    };
  };
}
