{
  self,
  inputs,
  ...
}: {
  flake.homeModules.firefox = {
    pkgs,
    system,
    lib,
    ...
  }: let
    hexToRgb = hex: let
      value = lib.removePrefix "#" hex;
      pairs = builtins.genList (i: builtins.substring (i * 2) 2 value) 3;
      hexToInt = lib.fromHexString;
    in {
      r = hexToInt (builtins.elemAt pairs 0);
      g = hexToInt (builtins.elemAt pairs 1);
      b = hexToInt (builtins.elemAt pairs 2);
    };

    catppuccin = lib.mapAttrs (_: hexToRgb) self.media.catppuccinMocha;
  in {
    programs.librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.fingerprintingProtection.override" = "+AllTargets, -CSSPrefersColorScheme";
        "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
        "privacy.clearOnShutdown_v2.cache" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "network.cookie.lifetimePolicy" = 0;
        "browser.startup.page" = 3;
        "browser.sessionstore.resume_session_once" = false;
        "browser.sessionstore.resume_from_crash" = true;
        "font.name-list.emoji" = "Twemoji SVG, Twemoji Mozilla";
        "ui.systemUsesDarkTheme" = 1;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      globalExtensions = with inputs.firefox-addons.packages.${system}; [
        sponsorblock
        firefox-color
      ];

      profiles.default = {
        search = {
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

        extensions = {
          force = true;

          settings."FirefoxColor@mozilla.com".settings = {
            firstRunDone = true;

            theme = {
              title = "Catppuccin Mocha Blue";

              colors = with catppuccin; {
                toolbar = base;
                toolbar_text = text;
                frame = crust;
                tab_background_text = text;

                toolbar_field = mantle;
                toolbar_field_text = text;

                tab_line = blue;
                popup = base;
                popup_text = text;

                button_background_active = overlay0;

                frame_inactive = crust;

                icons_attention = blue;
                icons = blue;

                ntp_background = crust;
                ntp_text = text;

                popup_border = blue;
                popup_highlight_text = text;
                popup_highlight = overlay0;

                sidebar_border = blue;
                sidebar_highlight_text = crust;
                sidebar_highlight = blue;
                sidebar_text = text;
                sidebar = base;

                tab_background_separator = blue;
                tab_loading = blue;
                tab_selected = base;
                tab_text = text;

                toolbar_bottom_separator = base;
                toolbar_field_border_focus = blue;
                toolbar_field_border = base;

                toolbar_field_focus = base;
                toolbar_field_highlight_text = base;
                toolbar_field_highlight = blue;

                toolbar_field_separator = blue;
                toolbar_vertical_separator = blue;
              };

              images = {
                additional_backgrounds = ["./bg-000.svg"];
                custom_backgrounds = [];
              };
            };
          };
        };

        userContent = with self.media.catppuccinMocha; ''
          @-moz-document url-prefix("about:"), url-prefix("chrome://") {
            body {
              background-color: ${crust} !important;
              color: ${text} !important;
            }

            select {
              background-color: ${base};
              color: ${text};
              border-color: ${subtext0};
            }

            .logo {
              background: image-set(url("file://${self.media.librewolfCatppuccin}")) !important;
            }

            .devtools-button.devtools-button-standalone {
              color: ${text} !important;
              border-color: ${subtext0} !important;
            }

            * {
              --text-color: ${text} !important;
              --text-color-deemphasized: ${subtext0} !important;

              --button-text-color: ${text} !important;
              --button-text-color-active: ${text} !important;
              --button-text-color-disabled: ${text} !important;
              --button-text-color-hover: ${text} !important;
              --button-text-color-selected: ${text} !important;
              --button-text-color-primary: ${base} !important;
              --button-text-color-primary-active: ${base} !important;
              --button-text-color-primary-disabled: ${base} !important;
              --button-text-color-primary-hover: ${base} !important;
              --button-text-color-primary-selected: ${base} !important;

              --icon-color: ${text} !important;
              --icon-color-critical: ${red} !important;
              --icon-color-information: ${blue} !important;
              --icon-color-success: ${green} !important;
              --icon-color-warning: ${yellow} !important;

              --border-color: ${text} !important;
              --border-color-interactive: ${text} !important;
              --border-color-deemphasized: ${subtext0} !important;

              --background-color-canvas: ${crust} !important;
              --background-color-box: ${base} !important;
              --background-color-box-info: ${surface0} !important;
              --background-color-critical: ${red}30 !important;
              --background-color-information: ${blue}30 !important;
              --background-color-success: ${green}30 !important;
              --background-color-warning: ${yellow}30 !important;
              --background-color-list-item-hover: ${blue}30 !important;

              --button-background-color-hover: ${surface0} !important;
              --button-background-color-active: ${base} !important;
              --button-background-color-primary-disabled: ${blue} !important;

              --table-background-color: ${mantle} !important;
              --table-row-background-color: ${mantle} !important;
              --table-row-background-color-alternate: ${base} !important;

              --color-accent-primary: ${blue} !important;
              --color-accent-primary-hover: ${lavender} !important;
              --color-accent-primary-active: ${blue} !important;

              --color-accent-secondary: ${sky} !important;
              --color-accent-secondary-hover: ${sapphire} !important;
              --color-accent-secondary-active: ${sky} !important;


              --theme-body-color: ${text} !important;
              --theme-toolbar-color: ${subtext0} !important;
              --theme-toolbar-selected-color: ${text} !important;
              --theme-icon-color: ${text} !important;
              --theme-icon-dimmed-color: ${overlay0} !important;
              --theme-icon-error-color: ${red} !important;
              --theme-icon-warning-color: ${yellow} !important;
              --theme-text-color-alt: ${overlay0} !important;
              --theme-body-background: ${base} !important;
              --theme-tab-toolbar-background: ${crust} !important;
              --theme-toolbar-background: ${base} !important;
              --theme-toolbar-hover: ${base} !important;
              --theme-toolbarbutton-color: ${subtext0} !important;
              --theme-toolbarbutton-hover-background: ${surface0} !important;
              --theme-toolbarbutton-active-background: ${blue}0C !important;
              --theme-toolbarbutton-checked-background: ${blue}0C !important;
              --theme-toolbarbutton-checked-color: ${blue} !important;
              --theme-toolbarbutton-checked-hover-background: ${text}10 !important;
              --theme-toolbarbutton-checked-active-background: ${blue}14 !important;
              --theme-splitter-color: ${surface0} !important;
              --theme-sidebar-background: ${mantle} !important;
              --theme-selection-background-hover: ${surface0} !important;
              --theme-focus-textinput-outline-color: ${blue} !important;
              --theme-link-color: ${blue} !important;
              --theme-internal-link-color: ${blue} !important;
              --theme-popup-background: ${base} !important;
              --theme-popup-color: ${text} !important;
              --theme-popup-border-color: ${subtext0} !important;

              --console-warning-color: ${yellow} !important;
              --console-warning-background: ${yellow}30 !important;
              --console-warning-border: ${yellow}40 !important;
              --console-error-color: ${red} !important;
              --console-error-background: ${red}30 !important;
              --console-error-border: ${red}40 !important;

              --toolbarbutton-background: ${base} !important;
              --toolbarbutton-hover-background: ${surface0} !important;
              --toolbarbutton-hover-color: ${text} !important;

              --tab-line-selected-color: ${blue} !important;
              --tab-line-hover-color: ${surface0} !important;

              --scrollbar-color: ${text}: !important;

              --row-striped-background: ${base} !important;
            }
          }
        '';
      };
    };
  };
}
