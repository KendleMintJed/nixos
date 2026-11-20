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
      xdg = let
        ghosttyExe = lib.getExe self.packages.${system}.ghostty;
      in {
        configFile."xdg-desktop-portal-termfilechooser/config".text = lib.generators.toINI {} {
          filechooser = {
            cmd = "${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh";
            default_dir = "$HOME";
            env = ''TERMCMD="${ghosttyExe}" --title=termfilechooser -e'';
            open_mode = "suggested";
            save_mode = "last";
          };
        };

        mimeApps = {
          enable = true;
          defaultApplications = {
            "inode/directory" = ["ghostty-directory.desktop"];
            "image/*" = ["nsxiv.desktop"];
          };
        };

        desktopEntries.ghostty-directory = {
          name = "Ghostty in Directory";
          comment = "Open Ghostty in a given directory";
          type = "Application";
          exec = let
            ghosttyDir = pkgs.writeShellScript "ghostty-directory" ''
              dir="$*"
              if [ -f "$dir" ]; then
                dir="$(dirname "$dir")"
              fi
              exec ${lib.getExe self.packages.${system}.niri} msg action spawn -- \
                ghostty --gtk-single-instance=true --working-directory="$dir"
            '';
          in "${ghosttyDir} %f";
          icon = "com.mitchellh.ghostty";
          terminal = false;
          mimeType = ["inode/directory"];
          noDisplay = true;
        };
      };
    };
  };
}
