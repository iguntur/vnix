{ config, pkgs, ... }:
{
  extraPackages = with pkgs; [ coreutils ];

  # extraConfigLuaPre = "";
  # extraConfigLua = "";
}
