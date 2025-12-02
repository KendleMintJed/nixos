{
  pkgs,
  lib,
  ...
}: {
  extensions = with pkgs.vscode-extensions; [
    rust-lang.rust-analyzer
    vadimcn.vscode-lldb
    tamasfe.even-better-toml
    fill-labs.dependi

    (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "slint";
        publisher = "slint";
        version = "1.14.1";
        hash = "sha256-/7zn5jpIqT//PriiJRmbygud7BmAMKVN8C6KOgfx9cI=";
      };

      nativeBuildInputs = with pkgs; [
        jq
        moreutils
      ];

      postInstall = ''
        jq '.contributes.configuration.properties."slint.lspBinaryPath".default = "${lib.getExe pkgs.slint-lsp}"' \
        $out/$installPrefix/package.json | sponge $out/$installPrefix/package.json

        # Ensure that the previous modification worked, by searching for the binary path
        grep -Fq ${lib.getExe pkgs.slint-lsp} $out/$installPrefix/package.json || {
          echo "Modifying 'slint.lspBinaryPath' in 'package.json' failed."
          exit 1
        }
      '';

      meta = {
        description = "This extension for VS Code adds support for the Slint design markup language.";
        homepage = "https://github.com/slint-ui/slint";
      };
    })
  ];
}
