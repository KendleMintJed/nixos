{
  self,
  inputs,
  ...
}: {
  flake.lib.mkNvfConfig = {
    lib,
    host ? null,
    ...
  }: let
    mkLuaInline = lib.generators.mkLuaInline;
  in
    lib.recursiveUpdate {
      vim = {
        options = {
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          foldlevel = 99;
        };

        keymaps = [
          {
            key = "jk";
            mode = "i";
            silent = true;
            action = "<Esc>";
          }
        ];

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamedplus";
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        binds.whichKey.enable = true;
        binds.cheatsheet.enable = true;
        treesitter = {
          fold = true;
          indent.excludes = ["nix"];
          context = {
            enable = true;
            setupOpts = {
              separator = null;
              max_lines = "10%";
            };
          };
        };

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
          icons.enable = true;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          trouble.enable = true;
          lspconfig.enable = true;
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;

          nix.enable = true;

          rust = {
            enable = true;
            extensions.crates-nvim.enable = true;
          };
          python.enable = true;
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        ui = {
          noice = {
            enable = true;
            setupOpts.lsp.signature.enabled = true;
          };
          nvim-ufo.enable = true;
        };

        visuals.nvim-web-devicons.enable = true;

        utility.snacks-nvim.enable = true;
      };
    }
    (lib.optionalAttrs (host != null) {
      vim = {
        lsp.servers.nixd.settings.nixd = let
          thisFlake = "(builtins.getFlake \"${self}\")";
        in {
          nixpkgs.expr = "import ${thisFlake}.inputs.nixpkgs {}";
          options = {
            nixos.expr = "${thisFlake}.nixosConfigurations.${host}.options";
            home-manager.expr = "${thisFlake}.nixosConfigurations.${host}.options.home-manager.users.type.getSubOptions []";
          };
        };
        languages.nix.lsp.servers = ["nixd"];
      };
    });

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.neovim =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;

        modules = [
          ({...}: {
            config = self.lib.mkNvfConfig {inherit lib;};
          })
        ];
      }).neovim;
  };
}
