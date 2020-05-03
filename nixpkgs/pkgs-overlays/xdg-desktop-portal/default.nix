self: pkgs:

(pkgs.xdg-desktop-portal.override {
  pipewire_0_2 = pkgs.pipewire;
}).overrideAttrs (old: rec {
  version = "1.7.2";

  src = pkgs.fetchFromGitHub {
    owner = "flatpak";
    repo = old.pname;
    rev = version;
    sha256 = "0rkwpsmbn3d3spkzc2zsd50l2r8pp4la390zcpsawaav8w7ql7xm";
  };
})
