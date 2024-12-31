{ config, pkgs, ... }:
{
  extraPackages = with pkgs; [
    bat
    delta
    fd
    git
    ripgrep # a.k.a rg
    coreutils
  ];

  # extraConfigLuaPre = "";
  # extraConfigLua = "";
}
