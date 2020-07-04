self: pkgs:

let
  import-overlay = path: import path self pkgs;
in with pkgs;
{
  alsaLib-patched = pkgs.alsaLib.overrideAttrs (old: {
     #patches = old.patches ++ [
     #  ./pkgs-overlays/alsa-lib/environment-plugin-dir.patch
     patches = [
       ./pkgs-overlays/alsa-lib/alsa-plugin-conf-multilib.patch
    ];
  });

  global-cursor-theme = callPackage ./pkgs/global-cursor-theme.nix {};

  rnix-lsp = callPackage (fetchFromGitHub {
    owner = "nix-community";
    repo = "rnix-lsp";
    rev = "731f47c10c632452450071c925e236cecf458c2e";
    sha256 = "1maki4snq766gpcykzhirsw5zyy5aipzn10fj0pmb86ldjx9cim9";
  }) {};

  rustNightly = (rustChannelOf { date = "2020-04-22"; channel = "nightly"; });

  paperclip-cli = callPackage ./pkgs/paperclip.nix {};

  emacsNodePackages = { inherit (self.current-nodePackages)
    eslint import-js jsonlint prettier standardx tslint typescript;
  };

  emacsExtraPathPackages = with self; [
    crate2nix
    rnix-lsp nixpkgs-fmt fd
    stdenv.cc.bintools.bintools_bin diffutils
    llvmPackages.libclang llvmPackages.clang llvmPackages.bintools
    pkg-config
  ];

  emacs28-git-solo = import ./pkgs-overlays/emacs28-git self (pkgs // {
    inherit (self) current-nodejs emacsNodePackages emacsExtraPathPackages;
  });

  emacs28-git = ((pkgs.emacsPackagesGen self.emacs28-git-solo).emacsWithPackages)
    (epkgs: (with epkgs.melpaStablePackages; [
    ]) ++ (with epkgs.melpaPackages; [
      vterm
      nix-mode #nixos-options nixpkgs-fmt # TODO build refresh procedure
    ]) ++ (with epkgs.elpaPackages; [
    ]) ++ [
    ]);

  current-nodejs = pkgs.nodejs_latest;

  current-nodePackages = pkgs.nodePackages_latest // (pkgs.callPackage ./nodePackages
                                            ({ inherit pkgs; } // { pkgs = self; }));

  pass = import-overlay ./pkgs-overlays/pass;

  xdg-desktop-portal-gtk = import-overlay ./pkgs-overlays/xdg-desktop-portal-gtk;

} // {
  # screensharing

  firefox-wayland-pipewire-unwrapped = import-overlay ./pkgs-overlays/firefox;

  firefox-wayland-pipewire = wrapFirefox self.firefox-wayland-pipewire-unwrapped {
    gdkWayland = true;
  };

  pipewire = import-overlay ./pkgs-overlays/pipewire;


} // {
  waylandPkgs = (pkgs.waylandPkgs or {}) // {
  };
} //
(import-overlay ./pkgs-overlays/jetbrains)
