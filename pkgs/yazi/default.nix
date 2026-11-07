{ writeShellScriptBin, yazi-original }:
writeShellScriptBin "yazi" ''
  exec ${yazi-original}/bin/yazi "$@"
''
