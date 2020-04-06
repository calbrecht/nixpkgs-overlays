self: pkgs:

pkgs.firefoxPackages.firefox.overrideAttrs (old: rec {
  buildInputs = old.buildInputs ++ [
    pkgs.pipewire
  ];
  patches = old.patches ++ [(
    (pkgs.fetchpatch {
      url = "https://src.fedoraproject.org/rpms/firefox/raw/8cb9a2a5617cae1a8c72cf8842036cc363e6da08/f/firefox-pipewire.patch";
      sha256 = "1xhy6cvr2w6prxfcxpbw2i6mzx7daxnibyykfk2n2fjpx7i28gaj";
    }))
    ./firefox-pipewire-patch-fpermissive.patch
  ];
})
