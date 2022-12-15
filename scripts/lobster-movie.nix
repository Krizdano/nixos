{ stdenv
, lib
, fetchFromGitHub
,makeWrapper
}:


stdenv.mkDerivation {
  pname = "lobster-movie";
  version = "3.0.4";

  src = fetchFromGitHub {
    owner = "justchokingaround";
    repo = "lobster";
    rev = "e5b04464e4ebab6c719f8fc5c9396b3bcf6cceae";
    sha256 = "sha256-Jn+StkcIrSXlbhKIsQnHnJofe5OO3UhPYejTDm20EYU=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    chmod +x lobster.sh
    cp -r lobster.sh $out/bin/lobster 
    '';

    meta = with lib; {
      description = "A cli tool to watch movies and series";
    };

}


