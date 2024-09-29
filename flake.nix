{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    #neovim.url = "github:neovim/neovim/master";
    lizzvim.url = "github:seattlelizzard/nix-vim/0.0.13";
    helix.url = "github:helix-editor/helix/master";

  };

  outputs = { self, nixpkgs, lizzvim, helix, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.lizzardlix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix 
        ./home.nix
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
