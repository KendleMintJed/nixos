{
  description = "KendleMintJed's Nix Config";

  inputs = {
    # Package repos
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Utility
    flake-parts.url = "github:hercules-ci/flake-parts";
    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deno2nix = {
      url = "github:hzrd149/deno2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Applications
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    septabee = {
      url = "github:Ap6661/septabee-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    must-source = {
      url = "github:pdfrg/must";
      flake = false;
    };
    affinity = {
      url = "github:mrshmllow/affinity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rcheck.url = "git+ssh://git@github.com/KendleMintJed/rcheck.git";

    # theme
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-gtk = {
      url = "git+https://github.com/VanillaDaFur/catppuccin-gtk.git?submodules=1";
      flake = false;
    };
    catppuccin-yazi = {
      url = "github:catppuccin/yazi";
      flake = false;
    };
    catppuccin-delta = {
      url = "github:catppuccin/delta";
      flake = false;
    };
    catppuccin-userstyles = {
      url = "github:catppuccin/userstyles";
      flake = false;
    };
    catppuccin-userstyles-yt-fix = {
      url = "https://github.com/catppuccin/userstyles/pull/2341.patch";
      flake = false;
    };
    noctalia-palettes = {
      url = "github:noctalia-dev/community-palettes";
      flake = false;
    };
  };

  nixConfig = {
    extra-substituters = ["https://cache.forall.systems"];
    extra-trusted-public-keys = [
      "cache.forall.systems:5PmD7QO4MSF8YgyRZtkSGXRDo96H3bybIf2SsQh8ScI="
    ];
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib.fileset) toList fileFilter;

    isNixModule = file:
      file.hasExt "nix"
      && file.name != "flake.nix"
      && !lib.hasPrefix "_" file.name;

    importTree = path:
      toList (fileFilter isNixModule path);

    mkFlake = inputs.flake-parts.lib.mkFlake {inherit inputs;};
  in
    mkFlake {
      systems = ["x86_64-linux"];
      imports = importTree ./.;
    };
}
