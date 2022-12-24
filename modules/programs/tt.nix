{ buildGoModule, lib, fetchFromGitHub }:

buildGoModule rec {
  pname = "tt";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "lemnos";
    repo = "tt";
    rev = "9efcc1496fe03971d40df21ef873b46725787913";
    sha256 = "sha256-7mC2WcEawTHBFNO+svj/9/s2WBcecN3dmpatf6oKYWk=";
  };

   postInstall = ''
   mv $out/bin/src $out/bin/tt
  '';

  vendorHash = "sha256-iny0OKInHqoXzYcEtd4f0T/yty5/z3k3yFbDo5yazes=";

  meta = with lib; {
    description = "Simple command-line type test, written in Go";
   # homepage = "https://github.com/knqyf263/pet";
    #license = licenses.mit;
    #maintainers = with maintainers; [ kalbasit ];
  };
}
