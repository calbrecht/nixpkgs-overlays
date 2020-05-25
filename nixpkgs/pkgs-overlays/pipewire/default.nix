self: pkgs:

let
  metadata = import ./metadata.nix;
in
pkgs.pipewire.overrideAttrs (old: rec {
  version = metadata.rev;

  src = pkgs.fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "pipewire";
    repo = "pipewire";
    rev = version; #"7f271ef982bd3c93c39d018e4c8c45052c5e70a5";
    sha256 = metadata.sha256; #"1xyd6p43cj9jl0bqzn06myn6lsm8qwrz0hfy3szmrxl1197v5fnn";
  };

  buildInputs = old.buildInputs ++ (with self; [
  ]);

  patches = [];

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
