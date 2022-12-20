{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonPackage rec {
  pname = "pdftty";
  version = "0.0.2";

  src = fetchFromGitHub {
    owner = "kpj";
    repo = "pdftty";
    rev = "cf5b5a0b2acc2b80e451a41359f361832c992a3e";
    sha256 = "sha256-q03+1gV75H3r9hdfghcCqoPsQlO+018WObh9/KAOfbo=";
  };

 # propagatedBuildInputs = with python3.pkgs; [ setuptools httpx click beautifulsoup4 colorama ];

 # postPatch = ''
 #   substituteInPlace setup.py --replace "bs4" "beautifulsoup4"
 # '';

 # meta = with lib; {
   # homepage = "https://github.com/mov-cli/mov-cli";
   # description = "A cli tool to browse and watch movies";
   # license = licenses.gpl3Only;
   # maintainers = with maintainers; [ baitinq ];
  #};
}
