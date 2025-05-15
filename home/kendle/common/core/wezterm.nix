{pkgs, ...}: {
  programs.kitty = {
    enable = true;

    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
      size = 20;
    };

    shellIntegration.enableZshIntegration = true;
    extraConfig = ''
      shell ${pkgs.zsh}/bin/zsh
    '';
  };
}
