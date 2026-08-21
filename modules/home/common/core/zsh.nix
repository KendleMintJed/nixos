{self, ...}: {
  flake.homeModules.zsh = {
    pkgs,
    lib,
    ...
  }: {
    home.shell.enableZshIntegration = true;

    programs.fzf = {
      enable = true;
      enableZshIntegration = false;
    };

    programs.zoxide.enable = true;

    programs.oh-my-posh = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.oh-my-posh;
    };

    programs.zsh = {
      enable = true;
      autocd = true;

      history = {
        append = true;
        ignoreSpace = true;
      };

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        cd = "z";
        ls = "${lib.getExe pkgs.eza} --color=always --icons=always";
        la = "${lib.getExe pkgs.eza} --color=always --icons=always -a";
        ll = "${lib.getExe pkgs.eza} --color=always --icons=always --long --git --no-filesize --no-time --no-user --no-permissions";
        lt = "${lib.getExe pkgs.eza} --color=always --icons=always --tree";
        md = "mkdir";
        lg = "${lib.getExe pkgs.lazygit}";
        cls = "clear";
      };

      plugins = with pkgs; [
        {
          name = "zsh-vi-mode";
          src = "${zsh-vi-mode}/share/zsh-vi-mode";
        }
        {
          name = "fzf-tab";
          src = "${zsh-fzf-tab}/share/fzf-tab";
        }
      ];

      localVariables = {
        ZVM_VI_ESCAPE_BINDKEY = "jk";
        ZVM_LINE_INIT_MODE = "i";
        SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)";
        MANPAGER = "nvim +Man!";
      };

      initContent = ''
        # Set options
        setopt extended_glob dot_glob interactive_comments no_beep
        zle_highlight=('paste:none')
        zvm_after_init_commands+=('source <(${pkgs.fzf}/bin/fzf --zsh)')
      '';
    };
  };
}
