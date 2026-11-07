# nixpkgs

Opinionated [Nix](https://nix.dev/) repository.

## Usage

A [flake](https://nix.dev/concepts/flakes). The first package, `yazi`, is a thin
bash wrapper around [nixpkgs' `yazi`](https://github.com/NixOS/nixpkgs) — it just
`exec`s the real binary, leaving a place to add personal tuning later.

```
$ nix build .#yazi        # or .#default
$ ./result/bin/yazi --version
```

Or as an overlay, to use the wrapper inside any nixpkgs:

```nix
nixpkgs.overlays = [ your-flake.overlays.default ];
```

## Layout

```
flake.nix            # packages.{yazi,default} per system + overlays.default
pkgs/
  yazi/default.nix   # the bash wrapper (writeShellScriptBin, exec ${yazi-original}/bin/yazi)
```

Each package lives in `pkgs/<name>/default.nix` and is instantiated with
`callPackage`; the wrapped dependency is passed explicitly so the wrapper never
shadows upstream's own `yazi-unwrapped` attribute.

## References

- [Nix](https://nix.dev/)
- [NixOS](https://nixos.org/)
- [NixOS/nixpkgs](https://github.com/NixOS/nixpkgs)
- [sfmunoz/nix-playground](https://github.com/sfmunoz/nix-playground)
