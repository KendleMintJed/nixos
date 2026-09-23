{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.must = pkgs.buildGoModule {
      pname = "must";
      version = "0.3.2";

      src = inputs.must-source;
      vendorHash = "sha256-EAIK7KIQ7krXWboi7Wimqmfn2PrhiGm/nRA8D3uAScw=";

      nativeBuildInputs = with pkgs; [
        makeWrapper
      ];

      postInstall = ''
        runHook prePostInstall

        wrapProgram $out/bin/must \
          --prefix PATH : ${
          lib.makeBinPath (with pkgs; [
            (mpv.override {scripts = [mpvScripts.mpris];})
            libnotify
            pulseaudio
          ])
        }

        runHook postPostInstall
      '';
    };
  };
}
