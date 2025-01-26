{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      lua_ls = {
        enable = true;
        settings = {
          completion = {
            callSnippet = "Replace";
          };
          hint = { enable = true; };
          workspace = {
            checkThirdParty = false;
          };
        };
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      lua = [
        "stylua"
      ];
    };
  };

  extraPackages = with pkgs; [
    stylua # Opinionated Lua code formatter
  ];
}
