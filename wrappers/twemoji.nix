{...}: {
  perSystem = {pkgs, ...}: {
    packages.twemoji-color-font = pkgs.twemoji-color-font.overrideAttrs (oldAttrs: {
      nativeBuildInputs =
        (oldAttrs.nativeBuildInputs or [])
        ++ [pkgs.fontforge];

      postInstall = ''
        runHook prePostInstall

        old="$out/share/fonts/truetype/TwitterColorEmoji-SVGinOT.ttf"
        new="$out/share/fonts/truetype/Twemoji-SVGinOT.ttf"
        fontforge -lang ff -c '
          Open($1);
          SelectWorthOutputting();
          SetFontNames( \
            "TwemojiSVG", \
            "Twemoji SVG", \
            "Twemoji SVG", \
            "Regular" \
          );
          Generate($2);
          Close();
        ' $old $new
        substituteInPlace $out/etc/fonts/conf.d/46-twemoji-color.conf \
          --replace-fail "Twitter Color Emoji" "Twemoji SVG"
        rm $old

        runHook postPostInstall
      '';
    });
  };
}
