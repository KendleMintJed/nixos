{self, ...}: {
  flake.nixosModules.niri = {
    pkgs,
    system,
    ...
  }: {
    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "ignore";
    };

    services.acpid = {
      enable = true;
      powerEventCommands = ''
        runtime_dir="$(${pkgs.systemd}/bin/loginctl show-user kendle -p RuntimePath --value)"
        wayland_display="$(${pkgs.findutils}/bin/find "$runtime_dir" -maxdepth 1 -type s -name 'wayland-*' -printf '%f\n' | ${pkgs.coreutils}/bin/head -n1)"

        if [ -n "$runtime_dir" ] && [ -n "$wayland_display" ]; then
          ${pkgs.util-linux}/bin/runuser -u kendle -- env \
            XDG_RUNTIME_DIR="$runtime_dir" \
            DBUS_SESSION_BUS_ADDRESS="unix:path=$runtime_dir/bus" \
            WAYLAND_DISPLAY="$wayland_display" \
            ${self.packages.${system}.noctalia}/bin/noctalia msg panel-toggle session
        fi
      '';
    };

    programs.niri = {
      enable = true;
      package = self.packages.${system}.niri;
    };

    programs.noctalia = {
      enable = true;
      package = self.packages.${system}.noctalia;
    };

    programs.xwayland.enable = true;
  };
}
