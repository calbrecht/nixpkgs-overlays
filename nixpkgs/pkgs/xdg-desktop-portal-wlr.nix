{ stdenv, fetchFromGitHub, fetchpatch
, meson, ninja, pkgconfig
, systemd, wayland, wayland-protocols
, pipewire, libdrm
}:

let
  metadata = {
    rev = "ccc8a31568b007c9109bb93488e9dac8a8fcf191";
    sha256 = "1b26rf2qcmmm887qnlxhifpnz7d52g97hy264wa9ismcjj9laps3";
  };
in
stdenv.mkDerivation rec {
  name = "xdg-desktop-portal-wlr-${version}";
  version = metadata.rev;

  src = fetchFromGitHub {
    owner = "emersion";
    repo = "xdg-desktop-portal-wlr";
    rev = version;
    sha256 = metadata.sha256;
  };

  nativeBuildInputs = [ pkgconfig meson ninja ];
  buildInputs = [ systemd ];
  propagatedBuildInputs = [ wayland wayland-protocols pipewire libdrm ];
  mesonFlags = [ "-Dauto_features=enabled" ];

  patches = [
    (fetchpatch {
      url = "https://patch-diff.githubusercontent.com/raw/emersion/xdg-desktop-portal-wlr/pull/19.patch";
      sha256 = "17pfi2sh2xfqwx4g42f3v6ac41f2s7222i96jn7k89q32gwx9b3j";
    })
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "xdg-desktop-portal backend for wlroots";
    homepage    = "https://github.com/emersion/xdg-desktop-portal-wlr";
    license     = licenses.mit;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ colemickens ];
  };
}
