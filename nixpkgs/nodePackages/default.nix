{pkgs, nodejs, stdenv }:

let
  nodePackages = import ./composition.nix {
    inherit pkgs nodejs;
    inherit (stdenv.hostPlatform) system;
  };
in
  nodePackages // {
    import-js = nodePackages.import-js.override (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [ nodePackages.node-pre-gyp ];
    });
  }
