{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  mkLuaInline = lib.generators.mkLuaInline;
in {
  imports = [inputs.nvf.homeManagerModules.default];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kendle";
  home.homeDirectory = "/home/kendle";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.shell.enableZshIntegration = true;

  programs.git = {
    enable = true;

    delta.enable = true;

    extraConfig = {
      credential.helper = "store";
      core.editor = "nvim";
      init.defaultBranch = "main";
      user = {
        # Otherwise git will try to guess a default user identity. see `man git config`.
        useConfigOnly = true;

        name = "KendleMintJed";
        email = "jamie.astonfamily@gmail.com";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings.git.paging = {
      colorArg = "always";
      pager = "${pkgs.delta}/bin/delta --paging=never";
    };
  };

  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings = {
      vim = {
        options = {
          shiftwidth = 2;
        };

        keymaps = [
          {
            key = "jk";
            mode = "i";
            silent = true;
            action = "<Esc>";
          }
        ];

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        binds.whichKey.enable = true;
        binds.cheatsheet.enable = true;
        treesitter.context.enable = true;
        utility.oil-nvim.enable = true;

        mini = {
          # Text editing
          comment.enable = true;
          move.enable = true;
          operators.enable = true;
          pairs.enable = true;
          splitjoin.enable = true;
          surround.enable = true;

          # General workflow
          basics = {
            enable = true;
            setupOpts.mappings.move_with_alt = true;
          };
          bracketed.enable = true;
          diff.enable = true;
          git.enable = true;
          jump.enable = true;
          jump2d.enable = true;
          pick.enable = true;
          sessions.enable = true;
          visits.enable = true;

          # Appearance
          indentscope = {
            enable = true;
            setupOpts.draw = {
              delay = 0;
              animation = mkLuaInline "function() return 0 end";
            };
          };
          notify.enable = true;
          starter.enable = true;
          tabline.enable = true;
          trailspace.enable = true;
        };

        lsp = {
          formatOnSave = true;
          trouble.enable = true;
        };

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;

          nix = {
            enable = true;
            lsp.server = "nixd";
          };
          rust.enable = true;
          rust.crates.enable = true;
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "macchiato";
        };

        ui.noice.enable = true;
      };
    };
  };

  # Builting zsh plugins
  programs.fzf.enable = true;
  programs.oh-my-posh = {
    enable = true;
    useTheme = "emodipt-extend";
  };
  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;
    autocd = true;

    history.append = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cd = "z";
      ls = "eza --color=always --icons=always";
      ll = "eza --color=always --icons=always --long --git --no-filesize --no-time --no-user --no-permissions";
      tree = "eza --color=always --icons=always --tree";
      md = "mkdir";
      lg = "lazygit";
      cls = "clear";
    };

    # Like shellAliases but substitutes anywhere on a line.
    shellGlobalAliases = {
    };

    plugins = with pkgs; [
      {
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];

    localVariables = {
      ZVM_VI_ESCAPE_BINDKEY = "jk";
    };

    initExtra = ''
      # Set options
      setopt extended_glob dot_glob interactive_comments no_beep
      zle_highlight=('paste:none')
    '';
  };

  programs.pay-respects.enable = true;

  programs.kitty = {
    enable = true;

    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };

    shellIntegration.enableZshIntegration = true;
    extraConfig = ''
      shell ${pkgs.zsh}/bin/zsh
    '';
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bat
    eza
    fzf
    zoxide
    fd
    tldr

    zsh-fzf-tab
    zsh-vi-mode
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kendle/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
