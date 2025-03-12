{ config, pkgs, lib, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "vnix-terminal";
      src = ./vnix-terminal;
    })
  ];

  extraConfigLua = ''
    require("vnix-terminal")
  '';
}
