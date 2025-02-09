{ config, lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      # html.enable = true;
    };

    conform-nvim.settings.formatters_by_ft = {
      html = [ "rustywind" ];
    };
  };

  extraPackages = with pkgs; [
    rustywind # A tool for formatting Tailwind CSS classes.
  ];
}

