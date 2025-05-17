{pkgs, ...}: {
  programs.wezterm = {
    enable = true;

    extraConfig = ''
      return {
        font = wezterm.font("JetBrainsMono Nerd Font"),
        font_size = 16.0,
        default_cursor_style = "SteadyBar",
        hide_tab_bar_if_only_one_tab = true,
        color_scheme = "Catppuccin Mocha",
        default_prog = {"zsh"},
      }
    '';
  };
}
