{ config, lib, pkgs, ... }:
{
  imports = [
    ./core
    ./coding
    ./editor
    ./sdk
    ./ui
    ./extra
    ./terminal
  ];

  editorconfig.enable = true;
  luaLoader.enable = true;

  performance = {
    # byteCompileLua.enable = true;
    # combinePlugins = {
    #   enable = true;
    #   standalonePlugins = [
    #   ];
    # };
  };

  plugins = {
    mini = {
      enable = true;
      # modules = { };
    };

    snacks = {
      enable = true;
    };

    snacks.settings = {
      bigfile = {
        enabled = true;
      };
      # quickfile = {
      #   enabled = false;
      # };
      # statuscolumn = {
      #   enabled = false;
      # };
      words = {
        debounce = 100;
        enabled = true;
      };
      input = {
        enabled = true;
      };
      picker = {
        enabled = true;
        ui_select = true; # replace `vim.ui.select` with the snacks picker
      };
    };
  };

  autoCmd = [
    {
      event = [ "User" ];
      callback.__raw = ''
        function()
          -- Override print to use snacks for `:=` command
          vim.print = function(...)
            Snacks.debug.inspect(...)
          end
        end
      '';
    }
  ];

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "boolean-swap";
      src = ./vnix-plugins/boolean-swap;
    })
  ]
  ++ lib.optionals config.plugins.vim-dadbod.enable [
    (pkgs.vimUtils.buildVimPlugin {
      name = "dadbod-simple-exec";
      src = ./vnix-plugins/dadbod-simple-exec;
      dependencies = with pkgs.vimPlugins; [
        nvim-treesitter
      ];
    })
  ]
  ++ lib.optionals config.plugins.lsp.servers.sqls.enable [
    (pkgs.vimUtils.buildVimPlugin {
      name = "sqls-simple-exec";
      src = ./vnix-plugins/sqls-simple-exec;
      dependencies = with pkgs.vimPlugins; [
        nvim-treesitter
      ];
    })
  ];
}
