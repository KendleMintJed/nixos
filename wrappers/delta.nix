{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    deltaWrapper = inputs.wrapper-modules.lib.wrapModule ({
      config,
      lib,
      wlib,
      pkgs,
      ...
    }: {
      imports = [wlib.modules.default];
      options = {
        settings = lib.mkOption {
          inherit (pkgs.formats.gitIni {listsAsDuplicateKeys = true;}) type;
          default = {};
          description = ''
            Delta configuration settings. (Generates a gitconfig file that delta uses).
            See <https://dandavison.github.io/delta/> for available options.
          '';
        };
        configFile = lib.mkOption {
          type = wlib.types.file {
            path = lib.mkOptionDefault config.constructFiles.deltaconfig.path;
          };
          default = {};
          description = "Generated gitconfig file given to delta.";
        };
      };
      config = {
        package = lib.mkDefault pkgs.delta;
        addFlag = [["--config" config.configFile.path]];
        constructFiles.deltaconfig = {
          relPath = "${config.binName}config";
          content = lib.generators.toGitINI config.settings + "\n" + config.configFile.content;
        };
      };
    });
  in {
    /*
    packages.delta = pkgs.stdenv.mkDerivation {
      name = "delta";

      buildCommand = ''
        mkdir -p $out/bin
        echo '#!${pkgs.stdenv.shell}' > $out/bin/delta
        echo '${lib.getExe pkgs.delta} --syntax-theme="Catppuccin Mocha" "$@"' >> $out/bin/delta
        chmod +x $out/bin/delta
      '';
    };
    */
    packages.delta = deltaWrapper.wrap {
      inherit pkgs;

      settings = {
        include.path = "${inputs.catppuccin-delta}/catppuccin.gitconfig";
        delta.features = "catppuccin-mocha";
      };
    };
  };
}
