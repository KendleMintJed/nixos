{
  description = "KendleMintJed's Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager.url = "github:nix-community/home-manager";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nvf.url = "github:notashelf/nvf";

    stylix.url = "github:nix-community/stylix";

    hyprland.url = "github:hyprwm/Hyprland";

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

    rcheck.url = "git+ssh://git@github.com/KendleMintJed/rcheck.git";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    nixcord.url = "github:kaylorben/nixcord";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib.extend (self: super: {custom = import ./lib {inherit (nixpkgs) lib;};});
  in {
    nixosConfigurations = builtins.listToAttrs (
      map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs lib host;
          };
          modules = [./hosts/nixos/${host}];
        };
      }) (builtins.attrNames (builtins.readDir ./hosts/nixos))
    );
  };
}
