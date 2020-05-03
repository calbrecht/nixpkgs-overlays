self: pkgs:

let
  import-overlay = path: import path self pkgs;
in with pkgs;
{
  alsaLib = pkgs.alsaLib.overrideAttrs (old: {
    patches = old.patches ++ [
      ./pkgs-overlays/alsa-lib/environment-plugin-dir.patch
    ];
  });

  global-cursor-theme = callPackage ./pkgs/global-cursor-theme.nix {};

  paperclip-cli = callPackage ./pkgs/paperclip.nix {};

  emacsNodePackages = { inherit (self.nodePackages)
    eslint import-js jsonlint prettier standardx tslint typescript;
  };

  emacs27-git-solo = import ./pkgs-overlays/emacs27-git self (pkgs // {
    inherit (self) nodejs emacsNodePackages;
  });

  emacs27-git = ((pkgs.emacsPackagesGen self.emacs27-git-solo).emacsWithPackages)
    (epkgs: (with epkgs.melpaStablePackages; [
    ]) ++ (with epkgs.melpaPackages; [
      vterm
    ]) ++ (with epkgs.elpaPackages; [
    ]) ++ [
    ]);

  nodejs = pkgs.nodejs-13_x;

  nodePackages = pkgs.nodePackages_13_x // (pkgs.callPackage ./nodePackages
                                            ({ inherit pkgs; } // { pkgs = self; }));

  pass = import-overlay ./pkgs-overlays/pass.nix;

  xdg-desktop-portal-gtk = import-overlay ./pkgs-overlays/xdg-desktop-portal-gtk;

} // {
  # screensharing

  firefox-wayland-pipewire-unwrapped = import-overlay ./pkgs-overlays/firefox;

  firefox-wayland-pipewire = wrapFirefox self.firefox-wayland-pipewire-unwrapped {
    gdkWayland = true;
  };

  pipewire = import-overlay ./pkgs-overlays/pipewire;

  xdg-desktop-portal = import-overlay ./pkgs-overlays/xdg-desktop-portal;

} // {
  waylandPkgs = (pkgs.waylandPkgs or {}) // {
    inherit (self) mako waybar;
  };
} //
(import-overlay ./pkgs-overlays/jetbrains)
