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

  emacsNodePackages = { inherit (pkgs.callPackage ./nodePackages
    ({ inherit pkgs; } // { pkgs = self; }))
    eslint import-js jsonlint prettier standardx tslint typescript;
  };

  emacs27-git = import ./pkgs-overlays/emacs27-git.nix self (pkgs // {
    inherit (self) nodejs emacsNodePackages;
  });

  nodejs = pkgs.nodejs-13_x;

  nodePackages = pkgs.nodePackages_13_x // self.emacsNodePackages;

  pass = import-overlay ./pkgs-overlays/pass.nix;

  xdg-desktop-portal-gtk = import-overlay ./pkgs-overlays/xdg-desktop-portal-gtk.nix;

} // {
  # screensharing

  firefox-wayland-pipewire-unwrapped = import-overlay ./pkgs-overlays/firefox.nix;

  firefox-wayland-pipewire = wrapFirefox self.firefox-wayland-pipewire-unwrapped {
    gdkWayland = true;
  };

  pipewire = import-overlay ./pkgs-overlays/pipewire.nix;

  xdg-desktop-portal = import-overlay ./pkgs-overlays/xdg-desktop-portal.nix;

  xdg-desktop-portal-wlr = pkgs.waylandPkgs.xdg-desktop-portal-wlr.override {
      pipewire = self.pipewire_0_3;
  };

} // {
  waylandPkgs = (pkgs.waylandPkgs or {}) // {
    inherit (self) mako xdg-desktop-portal-wlr waybar;
  };
} //
(import-overlay ./pkgs-overlays/jetbrains.nix)
