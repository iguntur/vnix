{ config, lib, ... }:
{
  plugins = {
    neogen = {
      enable = true;
      settings = {
        snippetEngine = lib.optionals config.plugins.luasnip.enable "luasnip";
      };
    };
  };
}
