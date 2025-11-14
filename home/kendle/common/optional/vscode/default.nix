{
  pkgs,
  lib,
  ...
} @ args: let
  profileFiles = [./rust.nix];
  getFileName = path: with builtins; replaceStrings [".nix"] [""] (baseNameOf path);
  mergeProfiles = base: super: let
    merged = lib.recursiveUpdate base super;
    mergedExtensions =
      (super.extensions or []) ++ (base.extensions or []);
    mergedKeybindings =
      (super.keybindings or []) ++ (base.keybindings or []);
  in
    merged
    // {
      extensions = mergedExtensions;
      keybindings = mergedKeybindings;
    };
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles = builtins.listToAttrs ((map (path: {
          name = getFileName path;
          value = mergeProfiles (import ./common.nix args) (import path args);
        })
        profileFiles)
      ++ [
        {
          name = "default";
          value = import ./common.nix args;
        }
      ]);
  };
  home = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    packages = with pkgs; [
      nixd
    ];
  };
}
