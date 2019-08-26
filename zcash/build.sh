nix-build -K -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'
