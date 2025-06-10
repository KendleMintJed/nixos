{...}: {
  imports = [
    ./common/core
  ];

  programs.home-manager.enable = true;

  home.username = "kendle";
  home.homeDirectory = "/home/kendle";

  home.file = {
  };

  home.sessionVariables = {
  };

  home.stateVersion = "24.11";
}
