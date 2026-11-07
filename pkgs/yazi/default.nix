{ writeShellScriptBin, runCommand, yazi-original }:

let
  configDir = runCommand "yazi-config" { } ''
    mkdir -p $out
    cp ${./yazi.toml} $out/yazi.toml
  '';
in
writeShellScriptBin "yazi" ''
  export YAZI_CONFIG_HOME="''${YAZI_CONFIG_HOME:-${configDir}}"
  exec ${yazi-original}/bin/yazi "$@"
''
