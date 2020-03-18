self: super:

with super; emacs26-nox.overrideAttrs (old: rec {
  name = "emacs27-git-${date}";
  date = "2019-09-22";

  src = fetchgit {
    url = /home/alab/ws/emacs;
    branchName = "master";
    sha256 = "0i08h9266zsn47p8vgzi9pf96kpds19rfkggc7kd7ybb6k475h79";
  };

  nativeBuildInputs = old.nativeBuildInputs ++ (with self; [
    git autoconf automake
  ]);

  #propagatedNativeBuildInputs = old.propagatedNativeBuildInputs ++ [
  #  nodejs (import /home/alab/ws/import-js {}).package
  #];

  patches = [];

  configureFlags = [
    "--without-x"
    "--without-makeinfo"
  ];

  enableParallelBuilding = true;
  doCheck = false;

  prePatch = ''
    ./autogen.sh
  '';

  preConfigure = ''
    for i in $(find . -name Makefile.in); do
       substituteInPlace $i --replace /bin/pwd pwd
    done
  '';

  preInstall = ''
  '';
})
