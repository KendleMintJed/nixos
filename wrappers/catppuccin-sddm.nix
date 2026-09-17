{self, ...}: {
  perSystem = {pkgs, ...}: {
    packages.catppuccin-sddm =
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "blue";
        font = "monospace";
        loginBackground = true;
        background = self.media.wallpaper;
        userIcon = true;
      }).overrideAttrs (_: {
        postInstall = ''
          loginPanelFile="$(echo $configFile | sed 's/theme.conf/Components\/LoginPanel.qml/g')"
          substituteInPlace $loginPanelFile \
            --replace-fail '"../assets/defaultIcon.png"' '""'
          substituteInPlace $loginPanelFile \
            --replace-fail '"/var/lib/AccountsService/icons/" + user' \
            '"${self.media.avatar}"'
        '';
      });
  };
}
