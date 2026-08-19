{pkgs, ...}: {
  extensions = with pkgs.vscode-extensions; [
    ms-python.python
    ms-python.debugpy
    ms-toolsai.jupyter
  ];
}
