Firefox screensharing

in your /etc/configuration.nix

```
{
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway";# https://github.com/emersion/xdg-desktop-portal-wlr/issues/20
    XDG_SESSION_TYPE = "wayland";# https://github.com/emersion/xdg-desktop-portal-wlr/pull/11
  };
    
  services.pipewire.enable = true;
 
  services.xdg = {
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

~/.config/systemd/user.control/pipewire.service

```
[Unit]
Description=Multimedia Service

# We require pipewire.socket to be active before starting the daemon, because
# while it is possible to use the service without the socket, it is not clear
# why it would be desirable.
#
# A user installing pipewire and doing `systemctl --user start pipewire`
# will not get the socket started, which might be confusing and problematic if
# the server is to be restarted later on, as the client autospawn feature
# might kick in. Also, a start of the socket unit will fail, adding to the
# confusion.
#
# After=pipewire.socket is not needed, as it is already implicit in the
# socket-service relationship, see systemd.socket(5).
Requires=pipewire.socket

[Service]
Type=simple
ExecStart=/home/alab/bin/pipewire
Restart=on-failure

[Install]
Also=pipewire.socket
WantedBy=default.target

```

/home/alab/bin/pipewire

```
#!/usr/bin/env bash

export PIPEWIRE_DEBUG=2
/path/to/latest/pipewire/bin/pipewire
```


~/.config/systemd/user.control/xdg-desktop-portal-wlr.service

```
[Unit]
Description=Portal service (wlroots implementation)

[Service]
Type=dbus
BusName=org.freedesktop.impl.portal.desktop.wlr
ExecStart=/home/alab/bin/xdg-desktop-portal-wlr
Restart=on-failure

```

/home/alab/bin/xdg-desktop-portal-wlr
```
#!/usr/bin/env bash

# -p BGRx
/path/to/latest/xdg-desktop-portal-wlr/libexec/xdg-desktop-portal-wlr -l TRACE

```
