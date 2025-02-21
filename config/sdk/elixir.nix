{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers.elixirls = {
      enable = true;
    };

    conform-nvim.settings.formatters_by_ft = {
      elixir = [ "rustywind" ];
      eelixir = [ "rustywind" ];
      heex = [ "rustywind" ];
    };
  };

  extraPackages = with pkgs; [
    rustywind # A tool for formatting Tailwind CSS classes.
  ];
}
