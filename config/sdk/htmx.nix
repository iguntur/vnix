{ config, lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      # BUG: https://github.com/Saghen/blink.cmp/issues/825
      # htmx.enable = true;
    };

    conform-nvim.settings.formatters_by_ft = { };
  };

  extraPackages = with pkgs; [
  ];
}

