self: pkgs:

pkgs.firefoxPackages.firefox.overrideAttrs (old: rec {
  buildInputs = old.buildInputs ++ [
    pkgs.pipewire_0_2
  ];
  patches = old.patches ++ [
    ((pkgs.fetchpatch {
      url = "https://src.fedoraproject.org/rpms/firefox/raw/034c5b3d5e5210a34532d3365ec346758e6dac01/f/firefox-pipewire.patch";
      sha256 = "1b15lhh3rsqcd18a3d60rka2479snzz8q0177lyp64d0raxjbrf2";
    }))
  ];
})
