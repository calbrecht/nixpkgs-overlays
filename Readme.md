Firefox screensharing on sway and NixOs master

You need the [overlays](https://github.com/calbrecht/nixpkgs-overlays/blob/master/nixpkgs/default.nix#L65) for `firefox-wayland-pipewire-unwrapped`, `firefox-wayland-pipewire` and `pipewire`, also `xdg-desktop-portal-wlr` from [nixpkgs-wayland](https://github.com/colemickens/nixpkgs-wayland)

in your /etc/configuration.nix

```
{
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway";# https://github.com/emersion/xdg-desktop-portal-wlr/issues/20
    XDG_SESSION_TYPE = "wayland";# https://github.com/emersion/xdg-desktop-portal-wlr/pull/11
  };
    
  services.pipewire.enable = false;
 
  xdg = {
    icons.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
      ];
      gtkUsePortal = true;
    };
  };

  systemd = {
    user.services.pipewire = {
      enable = true;
      description = "Multimedia Service";

      environment = {
        PIPEWIRE_DEBUG = "4";
      };
      path = [ pkgs.pipewire ];
      requires= [ "pipewire.socket" "xdg-desktop-portal.service" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.pipewire}/bin/pipewire";
        Restart = "on-failure";
      };

      wantedBy = [ "default.target" ];
    };

    user.sockets.pipewire = {
      enable = true;

      socketConfig = {
        Priority = 6;
        Backlog = 5;
        ListenStream= "%t/pipewire-0";
      };
    };

    user.services.xdg-desktop-portal-wlr = {
      enable = true;
      description = "Portal service (wlroots implementation)";

      requires= [ "pipewire.service" ];

      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.impl.portal.desktop.wlr";
        ExecStart = [ 
          "" # Override for trace
          "${pkgs.xdg-desktop-portal-wlr}/libexec/xdg-desktop-portal-wlr -l TRACE" 
        ];
        Restart = "on-failure";
      };
    };
  };
  users.extraUsers.user.extraGroups = [ "video" ];
}
```

in sway for restarting the services (if anything broke)

```
bindsym $mod+Shift+s exec "systemctl --user stop xdg-desktop-portal.service \
&& systemctl --user stop xdg-desktop-portal-wlr.service \
&& systemctl --user stop pipewire.service \
&& systemctl --user start pipewire.service \
&& sleep 1\
&& systemctl --user start xdg-desktop-portal-wlr.service \
&& systemctl --user start xdg-desktop-portal.service \
&& notify-send -t 1000 screensharing restarted"
```
