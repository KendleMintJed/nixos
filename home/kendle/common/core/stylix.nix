{...}: {
  stylix = {
    enable = true;
    targets = {
      librewolf = {
        profileNames = ["default"];
        colorTheme.enable = true;
      };

      nvf.enable = false;
      nixcord.enable = false;
    };
  };
}
