{self, ...}: {
  flake.configs.nvf.hostSpesific = {host, ...}: {
    vim = {
      lsp.servers.nixd.settings.nixd = let
        thisFlake = "(builtins.getFlake \"${self}\")";
      in {
        nixpkgs.expr = "import ${thisFlake}.inputs.nixpkgs {}";
        options = {
          nixos.expr = "${thisFlake}.nixosConfigurations.${host}.options";
          home-manager.expr = "${thisFlake}.nixosConfigurations.${host}.options.home-manager.users.type.getSubOptions []";
        };
      };
      languages.nix.lsp.servers = ["nixd"];
    };
  };
}
