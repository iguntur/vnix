{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = { };

    conform-nvim.settings.formatters_by_ft = {
      # ...
    };
  };

  # extraPackages = with pkgs; [
  # ];
}
