self: pkgs:

let
  nixops-libvirtd = pkgs.callPackage ./nixops-libvirtd {};
  nixops-hetzner = pkgs.callPackage ./nixops-hetzner {};

  nixopsSrc = pkgs.fetchFromGitHub {
    owner = "nixos";
    repo = "nixops";
    rev = "304a1d39abda82b20fa9956b0b1135869abc72a3";
    sha256 = "037cyjzzsnb2q6ssggyqj1wziqpcqy04i2b8zminwkyix9xwicsd";
  };

  nixops = (pkgs.poetry2nix.mkPoetryApplication {
    src = nixopsSrc;
    pyproject = "${nixopsSrc}/pyproject.toml";
    poetrylock = "${nixopsSrc}/poetry.lock";
  });

in
{
  inherit nixops-libvirtd;
  inherit nixops-hetzner;
  inherit nixops;
}