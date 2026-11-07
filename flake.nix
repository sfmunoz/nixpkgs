{
  description = "Opinionated Nix repository";

  inputs.nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

  outputs = { self, nixpkgs }: {
    packages = builtins.mapAttrs (system: pkgs: {
      yazi = pkgs.callPackage ./pkgs/yazi { yazi-original = pkgs.yazi; };
      default = self.packages.${system}.yazi;
    }) nixpkgs.legacyPackages;
    overlays.default = final: prev: {
      yazi = final.callPackage ./pkgs/yazi { yazi-original = prev.yazi; };
    };
  };
}
