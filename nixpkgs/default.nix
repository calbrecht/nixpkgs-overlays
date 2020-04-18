self: pkgs:

let
  import-overlay = path: import path self pkgs;
in with pkgs;
{
  global-cursor-theme = callPackage ./pkgs/global-cursor-theme.nix {};

  paperclip-cli = callPackage ./pkgs/paperclip.nix {};

  emacs27-git = import-overlay ./pkgs-overlays/emacs27-git.nix;

  pass = import-overlay ./pkgs-overlays/pass.nix;

  xdg-desktop-portal-gtk = import-overlay ./pkgs-overlays/xdg-desktop-portal-gtk.nix;

} // {
  # screensharing

  firefox-wayland-pipewire-unwrapped = import-overlay ./pkgs-overlays/firefox.nix;

  firefox-wayland-pipewire = wrapFirefox self.firefox-wayland-pipewire-unwrapped {
    gdkWayland = true;
  };

  pipewire_0_3 = import-overlay ./pkgs-overlays/pipewire.nix;

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
