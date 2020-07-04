self: pkgs:

pkgs.firefoxPackages.firefox.overrideAttrs (old: rec {
  buildInputs = old.buildInputs ++ [
    pkgs.pipewire
  ];

  patches = old.patches ++ [
    ((pkgs.fetchpatch {
      url = "https://src.fedoraproject.org/rpms/firefox/raw/e99b683a352cf5b2c9ff198756859bae408b5d9d/f/firefox-pipewire-0-3.patch";
      sha256 = "192ywcsza45cqwx3h9qnc77g0zfy4y630a94l7ls31md3nkhp1xi";
    }))
  ];

  postPatch = ''
    substituteInPlace media/webrtc/trunk/webrtc/modules/desktop_capture/desktop_capture_generic_gn/moz.build \
    --replace /usr/include ${pkgs.pipewire.dev}/include
  '' + old.postPatch;
})
