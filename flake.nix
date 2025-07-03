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

    helix.url = "github:helix-editor/helix/master";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.ideapad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./modules/common.nix

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