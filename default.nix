self: super:

(import ./nixpkgs/default.nix self super) //
(import ./nixpkgs-wayland/default.nix self super) //
(import ./nixpkgs-mozilla/rust-overlay.nix self super)
