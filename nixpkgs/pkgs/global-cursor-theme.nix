{ stdenv }:

# Adds a package defining a default icon/cursor theme.
# Based off of: https://github.com/NixOS/nixpkgs/pull/25974#issuecomment-305997110

stdenv.mkDerivation {
  name = "global-cursor-theme";
  unpackPhase = "true";
  outputs = [ "out" ];

  installPhase = ''
    mkdir -p $out/share/icons/default
    cat << EOF > $out/share/icons/default/index.theme
    [Icon Theme]
    Name=Default
    Comment=Default Cursor Theme
    Inherits=Paper
    EOF
  '';
}