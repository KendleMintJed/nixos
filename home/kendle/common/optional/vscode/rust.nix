{pkgs, ...}: {
  extensions = with pkgs.vscode-extensions; [
    rust-lang.rust-analyzer
    vadimcn.vscode-lldb
    tamasfe.even-better-toml
    fill-labs.dependi
  ];
}
