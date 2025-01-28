{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      java_language_server.enable = false;
      jdtls.enable = false;
    };

    conform-nvim.settings.formatters_by_ft = {
      # ...
    };
  };

  # extraPackages = with pkgs; [
  # ];
}
