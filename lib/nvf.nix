{
  self,
  lib,
  ...
}: {
  flake.lib.mkNvfConfig = {
    host ? null,
    pkgs,
    ...
  }:
    lib.recursiveUpdate
    (self.configs.nvf.core {inherit pkgs;})
    (
      lib.optionalAttrs (host != null)
      (self.configs.nvf.hostSpesific {inherit host;})
    );
}
