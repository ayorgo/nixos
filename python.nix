let
  pkgs = import <nixpkgs> { };
  python = pkgs.python313;

  cloud-sql-python-connector = pkgs.python313Packages.buildPythonPackage rec {
    pname = "cloud_sql_python_connector";
    version = "1.22.0";
    format = "wheel";
    src = pkgs.python313Packages.fetchPypi rec {
      inherit pname version format;
      sha256 = "sha256-KeftDEJmtJ65AnqN0kel/hDvcLka865436+S2EjUmsw=";
      dist = python;
      python = "py3";
    };
    dependencies = with pkgs.python313Packages; [
      aiohttp
      cryptography
      dnspython
      requests
      google-auth
      grpcio
      protobuf
      googleapis-common-protos
      pg8000
    ];
  };
in
pkgs.mkShell {
  packages = with pkgs; [
    (python.withPackages (
      ps: with ps; [
        pyarrow
        ipython
        pandas
        polars
        scikit-learn
        openpyxl
        plotly
        kaleido
        matplotlib
        ruff
        sqlalchemy
        cloud-sql-python-connector
        google-cloud-bigquery
        more-itertools
        db-dtypes
        altair
        vl-convert-python
      ]
    ))
  ];
}
