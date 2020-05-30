self: pkgs:

with pkgs; emacs26-nox.overrideAttrs (old: rec {
  name = "emacs28-git-${date}";
  date = "2020-05-09";

  src = ./emacs;

  nativeBuildInputs = old.nativeBuildInputs ++ [
    git autoconf automake makeWrapper
  ];

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
          ([ nodejs ] ++ pkgs.lib.attrValues pkgs.emacsNodePackages ++ pkgs.emacsExtraPathPackages)}"
  '';
})
