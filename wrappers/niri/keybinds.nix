{lib, ...}: {
  flake.configs.niri.keybinds = {
    self',
    pkgs,
    ...
  }: {
    input = {
      disable-power-key-handling = _: {};
      touchpad = {
        tap = _: {};
        natural-scroll = _: {};
      };
    };
    binds = let
      noctaliaExe = lib.getExe self'.packages.noctalia;
    in {
      # Niri

      # Navigation
      # # Change focus
      "Mod+H".focus-column-left = _: {};
      "Mod+L".focus-column-right = _: {};
      "Mod+J".focus-workspace-down = _: {};
      "Mod+K".focus-workspace-up = _: {};

      "Mod+Alt+H".focus-monitor-left = _: {};
      "Mod+Alt+L".focus-monitor-right = _: {};
      "Mod+Alt+J".focus-monitor-up = _: {};
      "Mod+Alt+K".focus-monitor-down = _: {};

      # # Move
      "Mod+Shift+H".move-column-left = _: {};
      "Mod+Shift+L".move-column-right = _: {};
      "Mod+Shift+J".move-workspace-down = _: {};
      "Mod+Shift+K".move-workspace-up = _: {};

      "Mod+Shift+Alt+H".move-column-to-monitor-left = _: {};
      "Mod+Shift+Alt+L".move-column-to-monitor-right = _: {};
      "Mod+Shift+Alt+J".move-workspace-to-monitor-down = _: {};
      "Mod+Shift+Alt+K".move-workspace-to-monitor-up = _: {};

      # # Misc
      "Mod+Q".close-window = _: {};
      "Mod+F".maximize-column = _: {};
      "Mod+Shift+F".fullscreen-window = _: {};
      "Mod+Alt+F".toggle-window-floating = _: {};
      "Mod+Tab".toggle-overview = _: {};

      # Utility
      "Mod+Return".spawn-sh = lib.getExe self'.packages.ghostty;
      "Mod+W".spawn-sh = lib.getExe pkgs.librewolf;
      "Mod+S".screenshot-screen = _: {};
      "Mod+Shift+S".screenshot = _: {};
      "Mod+Alt+S".screenshot-window = _: {};
      "Mod+P".spawn-sh = "${lib.getExe pkgs.hyprpicker} -b | ${pkgs.wl-clipboard}/bin/wl-copy";

      # Noctalia

      # Utility
      "Mod+R".spawn-sh = "${noctaliaExe} msg panel-toggle launcher";
      "Mod+semicolon".spawn-sh = "${noctaliaExe} msg session lock";
      "Mod+V".spawn-sh = "${noctaliaExe} msg panel-toggle clipboard";
      "Mod+period".spawn-sh = "${noctaliaExe} msg panel-toggle launcher /emo";
      "Mod+M".spawn-sh = "${noctaliaExe} msg panel-toggle control-center media";
      XF86PowerOff.spawn-sh = "${noctaliaExe} msg panel-toggle session";

      # Audio & Brightness
      XF86AudioRaiseVolume.spawn-sh = "${noctaliaExe} msg volume-up";
      XF86AudioLowerVolume.spawn-sh = "${noctaliaExe} msg volume-down";
      XF86AudioMute.spawn-sh = "${noctaliaExe} msg volume-mute";
      XF86MonBrightnessUp.spawn-sh = "${noctaliaExe} msg brightness-up";
      XF86MonBrightnessDown.spawn-sh = "${noctaliaExe} msg brightness-down";
    };
  };
}
