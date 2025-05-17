{
  lib,
  inputs,
  ...
}: let
  mkLuaInline = lib.generators.mkLuaInline;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

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
          files.enable = true;
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
          enable = true;
          formatOnSave = true;
          trouble.enable = true;
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;

          nix = {
            enable = true;
            lsp.server = "nixd";
          };
          rust = {
            enable = true;
            crates.enable = true;
          };
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
}
