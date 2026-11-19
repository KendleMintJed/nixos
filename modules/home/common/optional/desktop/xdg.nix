{self, ...}: {
  flake.homeModules.xdg = {
    lib,
    config,
    pkgs,
    system,
    ...
  }: {
    options.optionals.desktop.xdg = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.desktop.autoEnable;
      };
    };

    config = lib.mkIf config.optionals.desktop.xdg.enable {
      xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = lib.generators.toINI {} {
        filechooser = {
          cmd = "${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh";
          default_dir = "$HOME";
          env = ''TERMCMD="${lib.getExe self.packages.${system}.ghostty}" --title=termfilechooser -e'';
          open_mode = "suggested";
          save_mode = "last";
        };
      };
    };
  };
}
