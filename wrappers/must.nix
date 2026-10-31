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
      vendorHash = "sha256-VwawZAD59Nu/g5MTxr9hzHRWIRTfo0/Z9lPLn67gB6U=";

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
