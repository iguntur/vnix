{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      templ.enable = true;
    };

    conform-nvim.settings.formatters_by_ft = {
      templ = [
        "templ"
        "rustywind"
      ];
    };
  };

  extraPackages = with pkgs; [
    rustywind # A tool for formatting Tailwind CSS classes.
    templ # Language for writing HTML user interfaces in Go
  ];
}
