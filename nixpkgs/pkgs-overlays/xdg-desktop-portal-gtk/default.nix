self: pkgs:

pkgs.xdg-desktop-portal-gtk.overrideAttrs (old: {

  buildInputs = old.buildInputs ++ [
    # portal needs schema org.gnome.settings-daemon.plugins.xsettings
    # else it will not hint the fonts
    pkgs.gnome3.gnome-settings-daemon
  ];

})
