{lib, ...}: {
  flake.configs.niri.keybinds = {self', ...}: {
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
      # Builtin

      # Navigation
      # # Change focus
      "Mod+H".focus-column-left = _: {};
      "Mod+L".focus-column-right = _: {};
      "Mod+J".focus-workspace-down = _: {};
      "Mod+K".focus-workspace-up = _: {};
      # # Move
      "Mod+Shift+H".move-column-left = _: {};
      "Mod+Shift+L".move-column-right = _: {};
      "Mod+Shift+J".move-workspace-down = _: {};
      "Mod+Shift+K".move-workspace-up = _: {};
      # # Misc
      "Mod+Q".close-window = _: {};
      "Mod+F".maximize-column = _: {};
      "Mod+Shift+F".fullscreen-window = _: {};
      "Mod+Tab".toggle-overview = _: {};
      # Utility
      "Mod+Return".spawn-sh = lib.getExe self'.packages.ghostty;
      "Mod+Shift+S".screenshot = _: {};

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
