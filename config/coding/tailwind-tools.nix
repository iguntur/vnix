{ config, lib, ... }:
{
  plugins = {
    # TODO: re-enable: find alternative
    # deprecated repo
    tailwind-tools = {
      # enable = config.plugins.lsp.servers.tailwindcss.enable;
      settings = { };
    };
  };
}
