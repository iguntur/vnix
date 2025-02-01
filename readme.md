# vnix

> My personal neovim configuration

![Preview](./media/preview.png)

## Setup

### (Option 1) Standalone

```sh
nix run github:iguntur/vnix

# or enable the experimental features directly command line
nix run --extra-experimental-features 'nix-command flakes' github:iguntur/vnix
```

### (Option 2) As Flake Input

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # ...
    vnix.url = "github:iguntur/vnix";
  };

  outputs = inputs@{ nixpkgs, ... }: {
    # Option 1: NixOS or Nix Darwin
    environment.systemPackages = [
      inputs.vnix.packages.${system}.default;
    ];

    # Option 2: Home Manager
    home.packages = [
      inputs.vnix.packages.${system}.default;
    ];
  };
}
```

## Develop

```sh
git clone git@github.com:iguntur/vnix.git
cd vnix
nix run .
```

### Update

```sh
nix flake update
nix run .
```

## Credits

My setup was inspired by the [LazyVim](https://lazyvim.org) since my previous [neovim configuration](https://github.com/iguntur/nvim) was setup using it.
Thanks to nix-community and the [configuration examples](https://nix-community.github.io/nixvim/user-guide/config-examples.html) for the best guides.
