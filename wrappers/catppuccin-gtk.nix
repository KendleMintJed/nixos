{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.catppuccin-gtk =
      (pkgs.catppuccin-gtk.override {
        variant = "mocha";
      }).overrideAttrs (_: {
        src = inputs.catppuccin-gtk;
        version = "1.0.6";
        patches = [];
      });
  };
}
