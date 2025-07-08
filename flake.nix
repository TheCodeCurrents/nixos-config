{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # vscode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, nixpkgs, home-manager, nix-vscode-extensions, ... }@inputs: 
    let 
      system = "x86_64-linux";
      mkHost = hostName: import ./hosts/${hostName}/${hostName}.nix;
    in {
    # Overlays
    nixpkgs.overlays = [
      nix-vscode-extensions.overlays.default
    ];

    # Please replace my-nixos with your hostname
    nixosConfigurations.ideapad = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./modules/common.nix
        (mkHost "ideapad")

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.jflocke = import ./users/jflocke/home.nix;
        }

        { _module.args = { inherit inputs; };}
      ];
    };
    nixosConfigurations.yoga = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./modules/common.nix
        (mkHost "yoga")

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.jflocke = import ./users/jflocke/home.nix;
        }

        { _module.args = { inherit inputs; };}
      ];
    };
  };

}
