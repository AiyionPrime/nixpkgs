{
  ansicolors,
  attrs,
  buildPythonPackage,
  exceptiongroup,
  fetchFromGitHub,
  fetchpatch,
  grpcio,
  grpcio-tools,
  grpcio-reflection,
  jinja2,
  lib,
  mock,
  openssh,
  pexpect,
  psutil,
  py-netgear-plus,
  pyserial,
  pytestCheckHook,
  pytest-benchmark,
  pytest-dependency,
  pytest-mock,
  pyudev,
  pyusb,
  pyyaml,
  requests,
  setuptools,
  setuptools-scm,
  xmodem,
}:

buildPythonPackage rec {
  pname = "labgrid";
  version = "25.0.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "labgrid-project";
    repo = "labgrid";
    rev = "df51556a8986ef9da3769b90fe2f72745f43a1c6";
    hash = "sha256-nnmfZ7GBcefiDW5JSTyMryNOOZLZt2UzqDqksUrIwnQ=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/labgrid-project/labgrid/pull/1836.patch";
      sha256 = "sha256-GLAzote6BuxIzCUuc8N4mPCFZepW3lmJR1t+ZArZ/Kc=";
    })
  ];

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    ansicolors
    attrs
    exceptiongroup
    jinja2
    grpcio
    grpcio-tools
    grpcio-reflection
    pexpect
    py-netgear-plus
    pyserial
    pyudev
    pyusb
    pyyaml
    requests
    xmodem
  ];

  pythonRemoveDeps = [ "pyserial-labgrid" ];

  pythonImportsCheck = [ "labgrid" ];

  nativeCheckInputs = [
    mock
    openssh
    psutil
    pytestCheckHook
    pytest-benchmark
    pytest-mock
    pytest-dependency
  ];

  disabledTests = [
    # flaky, timing sensitive
    "test_timing"

    # flaky, depends on ssh connection
    "test_argument_device_expansion"
    "test_argument_file_expansion"
    "test_local_managedfile"
  ];

  pytestFlags = [ "--benchmark-disable" ];

  meta = {
    description = "Embedded control & testing library";
    homepage = "https://github.com/labgrid-project/labgrid";
    license = lib.licenses.lgpl21Plus;
    maintainers = with lib.maintainers; [ aiyion ];
    platforms = with lib.platforms; linux;
  };
}
