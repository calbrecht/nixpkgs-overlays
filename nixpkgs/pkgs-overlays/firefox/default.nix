self: pkgs:

pkgs.firefoxPackages.firefox.overrideAttrs (old: rec {
  buildInputs = old.buildInputs ++ [
    pkgs.pipewire
  ];

  patches = old.patches ++ [
    ((pkgs.fetchpatch {
      url = "https://src.fedoraproject.org/rpms/firefox/blob/9ab78f69bc21c3ee0cafc017e3ad3f7779e4006e/f/firefox-pipewire-0-3.patch";
      sha256 = "0h02365ybwfkrs55b1a701mf2qb617zkc9lmbid6w2f6w996rfz3";
    }))
  ];

  postPatch = ''
    substituteInPlace media/webrtc/trunk/webrtc/modules/desktop_capture/desktop_capture_generic_gn/moz.build \
    --replace /usr/include ${pkgs.pipewire.dev}/include
  '' + old.postPatch;
})
