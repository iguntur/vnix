{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    numb-nvim # Peek lines just when you intend
  ];

  extraConfigLua = ''
    require("numb").setup()
  '';
}
