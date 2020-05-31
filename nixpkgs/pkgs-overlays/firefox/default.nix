self: pkgs:

pkgs.firefoxPackages.firefox.overrideAttrs (old: rec {
  buildInputs = old.buildInputs ++ [
    pkgs.pipewire
  ];

  patches = old.patches ++ [
    ((pkgs.fetchpatch {
      url = "https://src.fedoraproject.org/rpms/firefox/raw/9ab78f69bc21c3ee0cafc017e3ad3f7779e4006e/f/firefox-pipewire-0-3.patch";
      sha256 = "18lnsrrcpdpvimnlrjqxgql3d3zp91kgmvwdxqrc2wv2j3gs3yz2";
    }))
  ];

  postPatch = ''
    substituteInPlace media/webrtc/trunk/webrtc/modules/desktop_capture/desktop_capture_generic_gn/moz.build \
    --replace /usr/include ${pkgs.pipewire.dev}/include
  '' + old.postPatch;
})
