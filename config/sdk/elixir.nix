{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers.elixirls = {
      enable = true;
    };

    conform-nvim.settings.formatters_by_ft = {
      # ...
    };
  };

  # extraPackages = with pkgs; [
  # ];
}
