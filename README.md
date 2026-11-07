# nixpkgs

Opinionated [Nix](https://nix.dev/) repository.

## References

- [Nix](https://nix.dev/)
- [NixOS](https://nixos.org/)
- [NixOS/nixpkgs](https://github.com/NixOS/nixpkgs)
- [Nixpkgs Reference Manual](https://nixos.org/manual/nixpkgs/stable/)
- [sfmunoz/nix-playground](https://github.com/sfmunoz/nix-playground)

## Profile

Install `yazi` package:
```
nix profile add github:sfmunoz/nixpkgs#yazi
```

Install `yazi` package (pinned):
```
nix profile add github:sfmunoz/nixpkgs/2d15a61#yazi
```

Alternative:

```
nix profile add 'git+https://github.com/sfmunoz/nixpkgs#yazi'
nix profile add 'git+https://github.com/sfmunoz/nixpkgs?rev=2d15a6126db3a157255af4cd93210fa6b9d34a42#yazi'
```

From local checkout:

```
nix profile add .#yazi
nix profile add ~/src/nixpkgs#yazi
```

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
