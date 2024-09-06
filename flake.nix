{
  description = "Home Manager configuration of antony";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    darwin,
    home-manager,
    nixvim,
    ...
  }: let
    commonModules = [
      nixvim.homeManagerModules.nixvim
      ./home.nix
    ];
    linuxConfig = username: hostname: profiles:
      home-manager.lib.homeManagerConfiguration rec {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        modules =
          commonModules
          ++ map (profile: ./profiles/${profile}.nix) profiles;

        extraSpecialArgs = {
          homeDir = "/home/";
          username = username;
        };
      };
    darwinConfig = username: hostname: profiles:
      home-manager.lib.homeManagerConfiguration rec {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;

        modules =
          commonModules
          ++ map (profile: ./profiles/${profile}.nix) profiles;

        extraSpecialArgs = {
          homeDir = "/Users/";
          username = username;
        };
      };
  in {
    homeConfigurations = {
      alpha = linuxConfig "antony" "alpha" [];
      M-T60L22YDWJ = darwinConfig "antony" "M-T60L22YDWJ" ["work"];
    };
  };
}
