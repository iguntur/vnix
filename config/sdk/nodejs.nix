{ lib, pkgs, ... }:
{
  plugins = {
    package-info = {
      enable = true;
      settings = { };
      lazyLoad.settings = {
        event = [ "BufEnter package.json" ];
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      # ...
    };
  };

  # extraPackages = with pkgs; [
  # ];
}
