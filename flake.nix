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
  }: {
    homeConfigurations."linux" = home-manager.lib.homeManagerConfiguration rec {
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        nixvim.homeManagerModules.nixvim
        ./home.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        homeDir = "/home/";
      };
    };
    homeConfigurations."darwin" = home-manager.lib.homeManagerConfiguration rec {
      pkgs = nixpkgs.legacyPackages.x86_64-darwin;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        nixvim.homeManagerModules.nixvim
        ./home.nix
        ./work.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        homeDir = "/Users/";
      };
    };
  };
}
