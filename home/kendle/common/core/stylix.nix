{
  inputs,
  pkgs,
  ...
}: {
  # imports = [inputs.stylix.homeManagerModules.stylix];
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets = {
      bat.enable = true;
      btop.enable = true;
      fzf.enable = true;
      hyprland.enable = true;
      lazygit.enable = true;
      mpv.enable = true;
      wezterm.enable = true;
      wofi.enable = true;
    };
  };
}
