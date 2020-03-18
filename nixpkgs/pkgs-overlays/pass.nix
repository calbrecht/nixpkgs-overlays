self: super:

with super; pass.overrideAttrs (old: rec {
  src = fetchFromGitHub {
    repo = "password-store";
    owner = "zx2c4";
    rev = "b87e91f984f45615b6459ff3829baa9130b8ef75";
    sha256 = "1xgfw238ph6fa8inrwqzfzfzqi16w4rr5sg79djb7iqz8njczbn8";
  };
  patches = [];
})
