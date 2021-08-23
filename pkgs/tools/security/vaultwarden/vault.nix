{ lib, stdenv, fetchurl, nixosTests }:

stdenv.mkDerivation rec {
  pname = "vaultwarden-vault";
  version = "2.21.1";

  src = fetchurl {
    url = "https://github.com/dani-garcia/bw_web_builds/releases/download/v${version}/bw_web_v${version}.tar.gz";
    sha256 = "sha256-hKHOnQiVq2uSqJmhTWPJXaz2F6GO9/bMy7G9BkZ2puI=";
  };

  buildCommand = ''
    mkdir -p $out/share/vaultwarden/
    cd $out/share/vaultwarden/
    tar xf $src
    mv web-vault vault
  '';

  passthru.tests = nixosTests.vaultwarden;

  meta = with lib; {
    description = "Integrates the web vault into vaultwarden";
    homepage = "https://github.com/dani-garcia/bw_web_builds";
    platforms = platforms.all;
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ msteen mic92 ];
  };
}
