{inputs, ...}: {
  perSystem = {system, ...}: {
    packages.catppuccin-stylus = let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [inputs.deno2nix.overlays.default];
      };

      source = pkgs.applyPatches {
        name = "catppuccin-userstyles-with-yt-fix";
        src = inputs.catppuccin-userstyles;

        patches = [
          inputs.catppuccin-userstyles-yt-fix
        ];
      };

      npmDeps = pkgs.mkDenoDeps {
        pname = "catppuccin-stylus";
        version = "1.0.0";
        src = source;
        entrypoint = "scripts/stylus-import/main.ts";
        hash = "sha256-bp3MqAsbvXNHA8kCnkJ29pOESIvn4LqACAsl2ZYpRzg=";
      };
    in
      pkgs.stdenv.mkDerivation {
        name = "catppuccin-stylus";

        src = source;

        nativeBuildInputs = with pkgs; [jq deno python3];

        buildPhase = ''
          runHook preBuild

          mkdir src
          cp -r $src/** src
          ln -s ${npmDeps}/node_modules src/node_modules
          ln -s ${npmDeps}/vendor src/vendor

          jq '.+{vendor: true}|.nodeModulesDir="manual"' src/deno.json > deno.json
          rm src/deno.json
          mv deno.json src

          (cd src; deno task --frozen ci:stylus-import)

          python3 ${./import-to-storage.py} src/dist/import.json storage.js
          substituteInPlace storage.js \
            --replace-fail '"default": "mauve"' '"default": "blue"'

          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall

          mkdir $out
          cp storage.js $out

          runHook postInstall
        '';
      };
  };
}
