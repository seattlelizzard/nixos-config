{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    khanelivim.url = "github:khaneliman/khanelivim";

  };

  outputs = { self, nixpkgs, khanelivim, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.lizzardlix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
      ];
    };
    #packages = with nixpkgs; [
    #  khanelivim.packages.x86_64-linux.default
    #];
    devShells.default = nixpkgs.mkShell {
        nativeBuildInputs = [ khanelivim.packages.x86_64-linux.default ];
      };
  };
}
