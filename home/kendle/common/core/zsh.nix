{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh-fzf-tab
    zsh-vi-mode
  ];

  home.shell.enableZshIntegration = true;

  # Builtin zsh plugins
  programs.fzf = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.oh-my-posh = {
    enable = true;
    settings = {
      version = 2;
      final_space = true;
      console_title_template = "{{ .Shell }} in {{ .Folder }}";
      blocks = [
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "path";
              style = "plain";
              foreground = "blue";
              background = "transparent";
              template = "{{ .Path }}";
              properties.style = "full";
            }
            {
              type = "git";
              style = "plain";
              foreground = "#6c6c6c";
              background = "transparent";
              template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";
              properties = {
                branch_icon = "";
                commit_icon = "@";
                fetch_status = true;
              };
            }
          ];
        }
        {
          type = "rprompt";
          overflow = "hidden";
          segments = [
            {
              type = "executiontime";
              style = "plain";
              foreground = "yellow";
              background = "transparent";
              template = "{{ .FormattedMs }}";
              properties.threshold = 5000;
            }
          ];
        }
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "text";
              style = "plain";
              foreground_templates = [
                "{{if gt .Code 0}}red{{end}}"
                "{{if eq .Code 0}}magenta{{end}}"
              ];
              background = "transparent";
              template = "❯";
            }
          ];
        }
      ];
      transient_prompt = {
        foreground_templates = [
          "{{if gt .Code 0}}red{{end}}"
          "{{if eq .Code 0}}magenta{{end}}"
        ];
        background = "transparent";
        template = "❯ ";
      };
      secondary_prompt = {
        foreground = "magenta";
        background = "transparent";
        template = "❯❯ ";
      };
    };
  };
  programs.zoxide.enable = true;

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
      ls = "eza --color=always --icons=always";
      la = "eza --color=always --icons=always -a";
      ll = "eza --color=always --icons=always --long --git --no-filesize --no-time --no-user --no-permissions";
      lt = "eza --color=always --icons=always --tree";
      md = "mkdir";
      lg = "lazygit";
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
}
