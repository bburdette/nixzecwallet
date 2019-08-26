{ stdenv
, fetchFromGitHub
, pkgconfig
, qt5
, openssl
, fftwFloat
, liquid-dsp
, bash
, libsodium
}:

stdenv.mkDerivation rec {
  name = "ZecWallet3";

  src = fetchFromGitHub {
    owner = "bburdette";
    repo = "zecwallet";
    rev = "dadf973daa0fc3b2f5ff02a2cd6a6c4a431404fa";
    sha256 = "17pgghm6i0zjq562g7q0isia2vnqsbxknc447sqnb8fhwnqz2hib";
  };

  preBuild = ''
    qmake zec-qt-wallet.pro CONFIG+=debug
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp bin/zcash-cli $out/bin
    cp bin/zcashd $out/bin
    cp bin/zecwallet $out/bin
  '';

  nativeBuildInputs = [  pkgconfig  ];
  buildInputs = [
    qt5.qtbase
    qt5.qtwebsockets
    openssl
    fftwFloat
    liquid-dsp
    bash
    libsodium
  ];

  meta = with stdenv.lib; {
    description = "ZCash wallet app";
    homepage = https://github.com/ZcashFoundation/zecwallet;
    maintainers = with maintainers; [ mog ];
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
