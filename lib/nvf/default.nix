{
  self,
  lib,
  ...
}: {
  flake.lib.mkNvfConfig = {host ? null, ...}:
    lib.recursiveUpdate
    (self.configs.nvf.core {inherit host;})
    (
      lib.optionalAttrs (host != null)
      (self.configs.nvf.hostSpesific {inherit host;})
    );
}
