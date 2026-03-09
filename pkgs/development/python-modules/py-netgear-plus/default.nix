{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchpatch,
  pytestCheckHook,
  lxml,
  requests,
  hatchling,
}:

buildPythonPackage rec {
  pname = "py-netgear-plus";
  version = "0.4.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "foxey";
    repo = "py-netgear-plus";
    tag = "v${version}";
    hash = "sha256-HoHXqAqVPqaw7WkRCi5AJ2dKG8IZX7l7bTp22KZBzdU=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/foxey/py-netgear-plus/pull/145.patch";
      sha256 = "sha256-GoX5J0dgb1/Q3zUHdE4To+kAi+ortDFSau49d37DM7Q=";
    })
  ];

  build-system = [ hatchling ];

  dependencies = [
    lxml
    requests
  ];

  pythonImportsCheck = [ "py_netgear_plus" ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  meta = {
    changelog = "https://github.com/foxey/py-netgear-plus/releases/tag/${src.tag}";
    description = "Python Library for NETGEAR Plus Switches";
    homepage = "https://github.com/foxey/py-netgear-plus";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ aiyion ];
  };
}
