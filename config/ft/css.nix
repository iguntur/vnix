{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      cssls.enable = true;
      tailwindcss.enable = true;
    };

    conform-nvim.settings.formatters_by_ft = {
      # ...
    };
  };

  extraPackages = with pkgs; [
    rustywind # A tool for formatting Tailwind CSS classes.
  ];
}
