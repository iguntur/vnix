{ config, lib, ... }:
{
  plugins = {
    neogen = {
      enable = true;
      snippetEngine = lib.optionals config.plugins.luasnip.enable "luasnip";
    };
  };
}
