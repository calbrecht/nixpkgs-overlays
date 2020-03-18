self: super:

with super;

{
  #ideaOracle = recurseIntoAttrs (
  #  callPackages ../ws/nixpkgs/pkgs/applications/editors/jetbrains {
      #androidsdk = androidsdk;
      #jdk = oraclejdk8psu;
      #jdk = openjdk11;
  #  }
  #);

  phpstorm = jetbrains.phpstorm.overrideDerivation (attrs: rec {
    name = "phpstorm-${version}";
    wmClass = "jetbrains";
    buildInputs = attrs.buildInputs ++ (with self; [
      nodejs yarn
    ]);
    extraBinPathPackages = with self; [ nodejs yarn ];
    version = "2020.1";
    #version = "2019.2.1";
    #version = "2019.3";
    build = "201.6251.26";
    #build = "192.6262.47";
    #build = "193.2956.42";
    src = fetchurl {
      #https://download.jetbrains.com/webide/PhpStorm-181.3986.12.tar.gz
      #url = "https://download.jetbrains.com/webide/PhpStorm-${version}.tar.gz";
      url = "https://download.jetbrains.com/webide/PhpStorm-${build}.tar.gz";
      sha256 = "13fa6a51c0ae88cb0d21bb76bf9f6bc2bfc7a3600386307ea9ab0b4dab3ec298";
      #sha256 = "08c2973d6b76e2be0917db2468af98e7ca5fb2b59c9d59e2c9f81df279eba6ad";
      #sha256 = "cfd5fa1c8bbe87e91707b80fad407a6d6dfd48f6f69c69eee7413ab9ecdbbd70";
    };
  });

  clion = jetbrains.clion.overrideDerivation (attrs: rec {
    name = "CLion-${version}";
    version = "${build}";
    build = "2016.1.2-RC";
    src = fetchurl {
      url = "https://download.jetbrains.com/cpp/${name}.tar.gz";
      sha256 = "12rwa9ss67gcvd8rbrjbm50xi7qfjq16ga8l2zmc7g20xn7bb46i";

    };
  });

  rubymine = jetbrains.ruby-mine.overrideDerivation (attrs: rec {
    name = "RubyMine-${version}";
    wmClass = "jetbrains";
    version = "${build}";
    build = "183.4284.57";
    src = fetchurl {
      # https://download.jetbrains.com/ruby/RubyMine-181.5281.41.tar.gz
      url = "https://download.jetbrains.com/ruby/${name}.tar.gz";
      sha256 = "aa6e6c3a9b9886766dffe9e2f57de7f0c893899b0066fc0b246c290af3670bcc";

    };
  });

  idea-ultimate = jetbrains.idea-ultimate.overrideDerivation (attrs: rec {
    name = "idea-ultimate-${version}";
    version = "2019.2.1";
    build = "192.6262.9";
    src = fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${build}.tar.gz";
      sha256 = "6e426590562fbb955beb453ec5b677c1da61287201235a84795b86c69ac59014";

    };
  });

  idea-community = jetbrains.idea-community.overrideDerivation (attrs: rec {
    name = "idea-community-${version}";
    version = "2020.1";
    build = "201.6251.22";
    src = fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIC-${build}.tar.gz";
      sha256 = "544c512d84e36918f837fdc0eedd1f5f1e11ad754ab03ee63f3829e2964fd925";
      #sha256 = "83ae01bfd4bcc4911213bd8c085a5503c36391f7c8093eb5099315d0ead95985";
    };
  });

  webstorm = jetbrains.webstorm.overrideDerivation (attrs: rec {
    name = "webstorm-${version}";
    version = "EAP-${build}-custom-jdk-linux";
    build = "144.3600.14";
    src = fetchurl {
      url = "http://download.jetbrains.com/webstorm/WebStorm-${version}.tar.gz";
      sha256 = "094mg6isd236qpdx7jq6v18bp5yfnva9qc2fp0znvdkgx47v6bvl";

    };
  });
}