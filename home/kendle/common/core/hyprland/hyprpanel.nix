{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  home.packages = with pkgs; [hyprpanel];

  programs.hyprpanel = {
    enable = true;
    overlay.enable = true;

    hyprland.enable = true;

    settings = {
      bar = {
        launcher.autoDetectIcon = true;
        clock.format = "%a %d %b %H:%M:%S";
      };

      menus.clock = {
        time.military = true;
        weather.enabled = false;
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme = {
        bar.transparent = true;

        font = {
          name = "JetBrainsMono Nerd Font";
          size = "16px";
        };
      };
    };
  };
}
