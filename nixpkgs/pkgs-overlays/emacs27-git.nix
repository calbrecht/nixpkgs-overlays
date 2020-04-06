self: pkgs:

with pkgs; emacs26-nox.overrideAttrs (old: rec {
  name = "emacs27-git-${date}";
  date = "2020-03-30";

  src = fetchgit {
    url = /home/alab/ws/emacs;
    branchName = "master";
    sha256 = "1wl8ac63yzrqm84qini80aa5cza42g0znsaiwm0wqsidmsidqlha";
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
