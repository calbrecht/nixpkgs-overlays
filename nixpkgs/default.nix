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

  gtk3_24_18 = pkgs.gtk3.overrideAttrs (old: rec {
    version = "3.24.18";
    src = fetchurl {
      url = "mirror://gnome/sources/gtk+/${stdenv.lib.versions.majorMinor version}/gtk+-${version}.tar.xz";
      sha256 = "1lia2ybd1661j6mvrc00iyd50gm7sy157bdzlyf4mr028rzzzspm";
    };
  });

  gtkmm3_24_18 = pkgs.gtkmm3.override {
    gtk3 = self.gtk3_24_18;
  };

  waybar = pkgs.waybar.override {
    gtkmm3 = self.gtkmm3_24_18;
  };

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

} // {
  waylandPkgs = (pkgs.waylandPkgs or {}) // {
    inherit (self) mako waybar;
  };
} //
(import-overlay ./pkgs-overlays/jetbrains.nix)
