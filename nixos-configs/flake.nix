{
  description = "My system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";
    # Настраиваем unstable с поддержкой unfree для sublimetext4
    unstablePkgs = import nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfreePredicate = pkg: builtins.elem (nixpkgs-unstable.lib.getName pkg) [
          "sublimetext4"
        ];
        permittedInsecurePackages = [
          "openssl-1.1.1w"
        ];
      };
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { unstable = unstablePkgs; };
      modules = [ ./configuration.nix ];
    };

    homeConfigurations.ed = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./home.nix ];
    };
  };
}
