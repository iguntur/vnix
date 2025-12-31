{ config, lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      kotlin_language_server = {
        enable = true;
        # config = { };
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      kotlin = [
        # "ktfmt"
        # "ktlint"
      ];
    };
  };

  # extraPackages = with pkgs; [
  # ];
}
