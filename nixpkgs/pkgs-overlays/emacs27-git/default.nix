self: pkgs:

with pkgs; emacs26-nox.overrideAttrs (old: rec {
  name = "emacs27-git-${date}";
  date = "2020-03-30";

  src = fetchgit {
    url = /home/alab/ws/emacs;
    branchName = "master";
    sha256 = "1wl8ac63yzrqm84qini80aa5cza42g0znsaiwm0wqsidmsidqlha";
  };

  nativeBuildInputs = old.nativeBuildInputs ++ [
    git autoconf automake makeWrapper
  ];

  propagatedNativeBuildInputs = (old.propagatedNativeBuildInputs or []) ++ [
    nodejs
  ] ++ pkgs.lib.attrValues pkgs.emacsNodePackages;

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

  postInstall = (old.postInstall or "") + ''
      wrapProgram $out/bin/emacs \
        --prefix PATH ":" "${pkgs.stdenv.lib.makeBinPath
          ([ nodejs ] ++ pkgs.lib.attrValues pkgs.emacsNodePackages)}"
  '';
})
