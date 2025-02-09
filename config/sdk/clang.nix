{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      # ccls.enable = true;
      clangd.enable = true;
    };

    conform-nvim.settings.formatters_by_ft = {
      # cpp = [ "clang_format" ];
    };
  };

  # extraPackages = with pkgs; [
  # ];
}
