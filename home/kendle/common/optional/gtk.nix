{pkgs, ...}: {
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];

  gtk = {
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
