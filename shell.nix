inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";  # Or your preferred channel
      khanelivim.url = "github:khaneliman/khanelivim";
    };

    outputs = { self, nixpkgs, khanelivim }: {
      # ... your other configuration ...

      # Or, use in a devShell:
      devShells.default = nixpkgs.mkShell {
        nativeBuildInputs = [ khanelivim.packages.${system}.default ];
      };
    };
