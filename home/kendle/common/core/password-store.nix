{pkgs, ...}: {
  programs.password-store = {
    enable = true;
    package = pkgs.pass-wayland.withExtensions (exts: with exts; [pass-tomb]);
  };
}
