self: pkgs:

(pkgs.xdg-desktop-portal.override {
  pipewire = self.pipewire_0_3;
}).overrideAttrs (old: rec {
  version = "1.7.1";

  src = pkgs.fetchFromGitHub {
    owner = "flatpak";
    repo = old.pname;
    rev = version;
    sha256 = "0qb8hys4dfr3sg22rbqvvwy1digrybg223cs0v7dq7w19yzvzmll";
  };
})
