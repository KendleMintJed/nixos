{
  pkgs,
  lib,
  ...
}: let
  flakePath = lib.custom.relativeToRoot "flake.nix";
in {
  extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
  ];
  userSettings = {
    "nix.serverPath" = "nixd";
    "nix.enableLanguageServer" = true;
    nixpkgs = {
      expr = "import (builtins.getFlake \"${flakePath}\") { }";
    };
    formatting = {
      command = ["alejandra"];
    };
    options = {
      nixos = {
        expr = "(builtins.getFlake \"${flakePath}\").nixosConfiguration.CONFIGNAME.options";
      };
      home_manager = {
        expr = "(builtins.getFlake \"${flakePath}\").homeConfiguration.CONFIGNAME.options";
      };
    };
  };
}
