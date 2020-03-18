{ stdenv, fetchFromGitHub, pkgconfig, openssl, rustPlatform, Security ? null
}:

rustPlatform.buildRustPackage rec {
  pname = "paperclip-cli";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner  = "wafflespeanut";
    repo   = "paperclip";
    rev    = "34a6ee9c5a25276298c6f2cbb61f55853860a8a8";
    sha256 = "1510jjh76zf36k38py8d4rvs7rajm47v9affjnzd1vdanig55csz";
  };

  //postPatch = ''
  //  echo LLOOOOOOOOOOOOOOOOOOOOLLLL
  //  make prepare
  //'';

  cargoBuildFlags = [ "--features=cli" ];
  cargoSha256 = "0zqfvbihf8xwgh092n9wzm3mdgbv0n99gjsfk9przqj2vh7wfvh2";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl ]  ++ stdenv.lib.optional stdenv.isDarwin Security;

  meta = with stdenv.lib; {
    description = "WIP OpenAPI tooling for Rust.";
    homepage    = https://github.com/wafflespeanut/papercl;
    license     = with licenses; [ mit ];
    maintainers = [ ];
    platforms   = platforms.all;
  };
}
