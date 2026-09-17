{
  self,
  lib,
  ...
}: {
  flake.lib.mkNvfConfig = args @ {host ? null, ...}:
    lib.recursiveUpdate
    (self.configs.nvf.core args)
    (
      lib.optionalAttrs (host != null)
      (self.configs.nvf.hostSpesific args)
    );
}
