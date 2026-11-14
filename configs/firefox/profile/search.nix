{...}: {
  flake.configs.firefoxModules.profileModules.search = {pkgs, ...}: {
    force = true;
    default = "duckduckgo";
    privateDefault = "ddg";
    order = ["duckduckgo" "ddg"];
    engines = {
      duckduckgo = {
        name = "DuckDuckGo";
        urls = [{template = "https://duckduckgo.com/?q={searchTerms}";}];
        icon = "https://duckduckgo.com/assets/icons/meta/DDG-icon_256x256.png";
        definedAliases = ["@duckduckgo" "@ddg"];
      };

      ddg.definedAliases = ["@nai"];

      nix-packages = {
        name = "Nix Packages";
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = ["@np"];
      };

      nixos-wiki = {
        name = "NixOS Wiki";
        urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
        iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
        definedAliases = ["@nw"];
      };

      mojeek.metaData.hidden = true;
      startpage.metaData.hidden = true;
    };
  };
}
