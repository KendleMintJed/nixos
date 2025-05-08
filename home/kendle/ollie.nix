{...}: {
  imports = [
    ./common/core
  ];

  home.username = "kendle";
  home.homeDirectory = "/home/kendle";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
