{ config, lib, pkgs, ... }:
{
  plugins = {
    # luasnip = {
    #   enable = true;
    #   settings = {
    #     history = true;
    #     delete_check_events = "TextChanged";
    #   };
    # };

    friendly-snippets.enable = true;

    # nvim-snippets = {
    #   enable = true;
    #   settings = {
    #     # create_autocmd = true;
    #     # create_cmp_source = true;
    #     extended_filetypes = {
    #       typescript = [ "javascript" ];
    #     };
    #     friendly_snippets = true;
    #     # ignored_filetypes = [ "lua" ];
    #     search_paths = [
    #       { __raw = "vim.fn.stdpath('config') .. '/snippets'"; }
    #       { __raw = "'~/dev/github.com/iguntur/vnix/snippets'"; }
    #     ];
    #   };
    # };

    mini.modules.snippets = {
      snippets = {
        __unkeyed-1.__raw = lib.mkIf config.plugins.friendly-snippets.enable # lua
          ''
            require("mini.snippets").gen_loader.from_file("${config.plugins.friendly-snippets.package}/snippets/global.json")
          '';

        __unkeyed-2.__raw = lib.mkIf config.plugins.friendly-snippets.enable # lua
          ''
            require("mini.snippets").gen_loader.from_file("~/dev/github.com/iguntur/vnix/snippets/java.json")
          '';

        __unkeyed-3.__raw = # lua
          ''
            require("mini.snippets").gen_loader.from_lang()
          '';
      };
    };
  };
}
