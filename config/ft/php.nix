{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = { };

    conform-nvim.settings.formatters_by_ft = {
      blade = [
        "blade-formatter"
        "rustywind"
      ];
      php = [ "pint" ];
    };
  };

  extraPackages = with pkgs; [
    blade-formatter # Laravel Blade template formatter
  ];
}
