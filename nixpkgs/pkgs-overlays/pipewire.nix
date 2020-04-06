self: pkgs:

pkgs.pipewire.overrideAttrs (old: rec {
  version = "0.3.2";

  src = pkgs.fetchFromGitHub {
    owner = "PipeWire";
    repo = "pipewire";
    rev = version;
    sha256 = "1aqhaaranv1jlc5py87mzfansxhzzpawqrfs8i08qc5ggnz6mfak";
  };

  buildInputs = old.buildInputs ++ (with self; [
    libsndfile
    bluez5
    vulkan-loader
    libpulseaudio
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
