{ config, lib, pkgs, ... }:
{
  plugins.kulala = {
    enable = true;
    lazyLoad.settings = {
      ft = [ "http" "rest" ];
    };
    settings = {
      winbar = true;
    };
  };

  plugins.rest = {
    enable = true;
    settings = { };
  };
}
