self: pkgs:

pkgs.pipewire.overrideAttrs (old: rec {
  version = "0.3.2";

  src = pkgs.fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "pipewire";
    repo = "pipewire";
    rev = "dfd1adf816dfee75ebec94f2de386fc73ececb02";
    sha256 = "1garm8bv0jjknwyivr63xsmw8s3jfgf6j6ky1w5fn0010zjqviif";
  };

  buildInputs = old.buildInputs ++ (with self; [
  ]);

  mesonFlags = [
    "-Ddocs=true"
    "-Daudiomixer=true"
    "-Daudiotestsrc=true"
    "-Dtest=true"
    "-Dvideotestsrc=true"
    "-Dvolume=true"
    "-Dgstreamer=true"
  ];
})
