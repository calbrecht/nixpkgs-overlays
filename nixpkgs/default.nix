self: super:
let
  import-overlay = path: import path self super;
in with super; {
  emacs27-git = import-overlay ./pkgs-overlays/emacs27-git.nix;
  global-cursor-theme = callPackage ./pkgs/global-cursor-theme.nix {};
  paperclip-cli = callPackage ./pkgs/paperclip.nix {};
  pass = import-overlay ./pkgs-overlays/pass.nix;

  vagrant = callPackage /home/alab/ws/vagrant {};

} // (import-overlay ./pkgs-overlays/jetbrains.nix)
