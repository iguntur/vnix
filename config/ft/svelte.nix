{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers.svelte = {
      enable = true;
    };

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
