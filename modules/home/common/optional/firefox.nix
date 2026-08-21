{inputs, ...}: {
  flake.homeModules.firefox = {pkgs, ...}: {
    programs.librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.override" = "+AllTargets, -CSSPrefersColorScheme";
        "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
        "privacy.clearOnShutdown_v2.cache" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "network.cookie.lifetimePolicy" = 0;
        "browser.startup.page" = 3;
        "browser.sessionstore.resume_session_once" = false;
        "browser.sessionstore.resume_from_crash" = true;
        "ui.systemUsesDarkTheme" = 1;
      };
      profiles.default.extensions = {
        force = true;
        packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          sponsorblock
        ];
      };
    };

    stylix.targets.librewolf = {
      enable = true;
      colorTheme.enable = true;
      profileNames = ["default"];
    };
  };
}
