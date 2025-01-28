{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = { };

    conform-nvim.settings.formatters_by_ft = {
      svelte = [
        "prettierd"
        "rustywind"
      ];
    };
  };

  # extraPackages = with pkgs; [
  # ];
}
