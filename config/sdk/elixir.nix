{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers.elixirls = {
      enable = true;
      package = pkgs.beam27Packages.elixir-ls;
    };

    conform-nvim.settings.formatters_by_ft = {
      elixir = [ "rustywind" "mix" ];
      eelixir = [ "rustywind" "mix" ];
      heex = [ "rustywind" "mix" ];
    };
  };

  extraPackages = with pkgs; [
    rustywind # A tool for formatting Tailwind CSS classes.
  ];
}
