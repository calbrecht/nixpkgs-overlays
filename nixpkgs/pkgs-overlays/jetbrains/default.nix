self: pkgs:

with pkgs;

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
    build = "201.6668.30";
    src = fetchurl {
      url = "https://download-cf.jetbrains.com/webide/PhpStorm-${build}.tar.gz";
      sha256 = "364b1b729c65bd10ca56875525ce615d7d39c52a93e1b2375a19b0a8a20a7bdb";
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
    build = "201.6487.11";
    src = fetchurl {
      url = "https://download-cf.jetbrains.com/idea/ideaIC-${build}.tar.gz";
      sha256 = "494bea2cf9104113683213915304bf94917e020d3502bb64375d7d3b87de41f3";
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