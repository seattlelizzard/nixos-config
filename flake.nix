{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    #neovim.url = "github:neovim/neovim/master";
    lizzvim.url = "github:seattlelizzard/nix-vim/0.0.13";
    helix.url = "github:helix-editor/helix/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs, lizzvim, helix, home-manager, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.lizzardlix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix 
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            
            home-manager.users.lizz = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            }
        {
          nixpkgs.overlays = [
            lizzvim.overlays.default
            helix.overlays.default
          ];
        }
      ];
    };
  };
}
