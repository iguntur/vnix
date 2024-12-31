{ pkgs, ... }:
{
  imports = [
    ./disable-keys.nix
    ./common.nix
    ./clipboard.nix
    ./utilities.nix
    ./tab.nix
    ./window.nix
  ];
}
