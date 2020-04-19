self: pkgs:

pkgs.firefoxPackages.firefox.overrideAttrs (old: rec {
  buildInputs = old.buildInputs ++ [
    pkgs.pipewire_0_2
  ];
  patches = old.patches ++ [
    #((pkgs.fetchpatch {
    #  url = "https://src.fedoraproject.org/rpms/firefox/raw/8cb9a2a5617cae1a8c72cf8842036cc363e6da08/f/firefox-pipewire.patch";
    #  #sha256 = "1xhy6cvr2w6prxfcxpbw2i6mzx7daxnibyykfk2n2fjpx7i28gaj";
    #  sha256 = "13jjkw8s0bmx9pg571r5acy1dn85gdvcnxc4p01m4c4b2vkgwxh1";
    #}))
    # https://src.fedoraproject.org/rpms/firefox/raw/143fa360a26e015372e3c2a1ad79f4b606409ed2/f/firefox-pipewire.patch
    ./firefox-pipewire-master.patch
  ];
})
