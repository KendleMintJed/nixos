{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.delta = pkgs.stdenv.mkDerivation {
      name = "delta";

      buildCommand = ''
        mkdir -p $out/bin
        echo '#!${pkgs.stdenv.shell}' > $out/bin/delta
        echo '${lib.getExe pkgs.delta} --syntax-theme="Catppuccin Mocha" "$@"' >> $out/bin/delta
        chmod +x $out/bin/delta
      '';
    };
  };
}
