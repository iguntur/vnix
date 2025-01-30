{ config, lib, pkgs, ... }:
{
  plugins = {
    luasnip = {
      enable = true;
      settings = {
        history = true;
        delete_check_events = "TextChanged";
      };
    };

    friendly-snippets.enable = true;

    mini.modules.snippets = {
      snippets = {
        __unkeyed-1.__raw = lib.mkIf config.plugins.friendly-snippets.enable # lua
          ''
            require("mini.snippets").gen_loader.from_file("${config.plugins.friendly-snippets.package}/snippets/global.json")
          '';
        __unkeyed-2.__raw = # lua
          ''
            require("mini.snippets").gen_loader.from_lang()
          '';
      };
    };
  };
}
