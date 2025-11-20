{
  pkgs,
  host,
  ...
}: let
  flakePath = "/home/kendle/nixos/flake.nix";
in {
  extensions = with pkgs.vscode-extensions; [
    vscodevim.vim
    usernamehw.errorlens
    github.copilot
    github.copilot-chat
    shardulm94.trailing-spaces
    arrterian.nix-env-selector
    jnoortheen.nix-ide
  ];
  userSettings = {
    "workbench.sideBar.location" = "right";

    "vim.insertModeKeyBindings" = [
      {
        before = ["j" "k"];
        after = ["<Esc>"];
      }
    ];

    "nix.serverPath" = "nixd";
    "nix.enableLanguageServer" = true;
    "nix.serverSettings" = {
      nixd = {
        formatting = {
          command = ["alejandra"];
        };
        options = {
          nixpkgs = {
            expr = "import (builtins.getFlake \"${flakePath}\") { }";
          };
          nixos = {
            expr = "(builtins.getFlake \"${flakePath}\").nixosConfigurations.${host}.options";
          };
          home-manager = {
            expr = "(builtins.getFlake \"${flakePath}\").homeConfigurations.${host}.options";
          };
        };
      };
    };
    "nixEnvSelector.useFlakes" = true;
  };
}
