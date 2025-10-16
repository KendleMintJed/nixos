{pkgs, ...}: {
  extensions = with pkgs.vscode-extensions; [
    vscodevim.vim
    usernamehw.errorlens
  ];
  userSettings = {
    "vim.insertModeKeyBindings" = [
      {
        before = ["j" "k"];
        after = ["<Esc>"];
      }
    ];

    "workbench.colorTheme" = "Catppuccin Mocha";
    "workbench.sideBar.location" = "right";

    "catppuccin.accentColor" = "blue";
    "catppuccin.customUIColors" = {
      "mocha" = {
        "statusBar.foreground" = "accent";
      };
    };
  };
}
