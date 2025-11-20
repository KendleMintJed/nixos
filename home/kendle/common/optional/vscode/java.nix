{pkgs, ...}: {
  extensions = with pkgs.vscode-extensions;
    [
      vscjava.vscode-java-pack
      vscjava.vscode-maven
      vscjava.vscode-gradle
      vscjava.vscode-java-debug
      vscjava.vscode-java-test
      vscjava.vscode-java-dependency
      redhat.java
      oracle.oracle-java
    ]
    ++ (with pkgs.vscode-marketplace; [
      dhruv.maven-dependency-explorer
    ]);
  userSettings = {
    "editor.rulers" = [80];
    "jdk.telemetry.enabled" = false;
  };
}
