{ stdenv
, fetchFromGitHub
, pkgconfig
, openssl
, bash
, libsodium
}:

stdenv.mkDerivation rec {
  name = "zcash";

  src = fetchFromGitHub {
    owner = "zcash";
    repo = "zcash";
    rev = "0512e9eb00f97172346e0fac854625d59771e4f7";
    sha256 = "0z5pbvic69p5vikcfgh02nz9cq7prn4c2mxny3iycxjmv1bxhika";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp zcashd $out/bin
    cp zcash-cli $out/bin
  '';

  nativeBuildInputs = [  pkgconfig  ];
  buildInputs = [
    openssl
    bash
    libsodium
  ];

  meta = with stdenv.lib; {
    description = "zcash";
    homepage = https://github.com/zcash/zcash;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
