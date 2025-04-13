{ config, lib, pkgs, ... }:
let
  dataPath = "$GUN_QUERY_PATH";
in
{
  globals = lib.mkIf config.plugins.vim-dadbod-ui.enable {
    db_ui_auto_execute_table_helpers = false;
    db_ui_execute_on_save = false;
    db_ui_disable_info_notifications = false;
    db_ui_show_database_icon = true;
    db_ui_use_nerd_fonts = true;
    db_ui_use_nvim_notify = true;
    db_ui_save_location.__raw = "vim.fn.expand('${dataPath}')";
    db_ui_tmp_query_location.__raw = "vim.fn.expand('${dataPath}/tmp')";
  };

  plugins = {
    vim-dadbod = {
      enable = true;
    };

    vim-dadbod-ui = {
      enable = config.plugins.vim-dadbod.enable;
    };

    vim-dadbod-completion = {
      enable = config.plugins.vim-dadbod-ui.enable;
    };

    conform-nvim.settings = {
      formatters_by_ft = {
        sql = [ "sqruff" ];
        mysql = [ "sqruff" ];
        plsql = [ "sqruff" ];
      };
    };

    fzf-lua.keymaps = {
      "<leader>fd" = {
        action = "files";
        settings = {
          prompt = "❯ ";
          cwd.__raw = ''vim.fn.expand("${dataPath}")'';
        };
        options = {
          silent = true;
          desc = "Database queries files";
        };
      };
    };

    lsp.servers.sqls = {
      enable = true;
      onAttach.function = /* lua */ ''
        require('sqls').on_attach(client, bufnr)
      '';
      settings = { };
    };
  };

  extraPlugins = lib.optionals config.plugins.lsp.servers.sqls.enable [
    (pkgs.vimUtils.buildVimPlugin {
      name = "sqls";
      src = pkgs.fetchFromGitHub {
        owner = "nanotee";
        repo = "sqls.nvim";
        rev = "main";
        hash = "sha256-bQKO5Kq4Jc8v7d6OSkkzjqYHzt8c5C71xzHHABErlsg=";
      };
    })
  ];

  extraConfigLuaPost = lib.mkIf config.plugins.vim-dadbod-ui.enable # lua
    ''
      vim.api.nvim_set_hl(0, "NotificationInfo", { bg = "None" }) -- DBUI Notifications
    '';

  keymaps = lib.optionals config.plugins.lsp.servers.sqls.enable [
    {
      mode = "n";
      key = "<localleader>db";
      action = "<cmd>SqlsSwitchDatabase<cr>";
      options = {
        silent = true;
        desc = "SQLS: Switch Database";
      };
    }
    {
      mode = "n";
      key = "<localleader>dc";
      action = "<cmd>SqlsSwitchConnection<cr>";
      options = {
        silent = true;
        desc = "SQLS: Switch Connection";
      };
    }
    {
      mode = "n";
      key = "<localleader>ds";
      action = "<cmd>SqlsShowSchemas<cr>";
      options = {
        silent = true;
        desc = "SQLS: Show Schemas";
      };
    }
    {
      mode = "n";
      key = "<localleader>dd";
      action = "<cmd>SqlsShowDatabases<cr>";
      options = {
        silent = true;
        desc = "SQLS: Show Databases";
      };
    }
  ]
  ++ lib.optionals config.plugins.vim-dadbod-ui.enable [
    {
      mode = "n";
      key = "<localleader>dT";
      action = "<cmd>DBUIToggle<cr>";
      options = {
        silent = true;
        desc = "DBUI: Toggle";
      };
    }
    {
      mode = "n";
      key = "<localleader>dH";
      action = "<cmd>DBUIHideNotifications<cr>";
      options = {
        silent = true;
        desc = "DBUI: Hide Notifications";
      };
    }
    {
      mode = "n";
      key = "<localleader>dF";
      action.__raw = ''
        function()
          vim.cmd("DBUIFindBuffer")
          vim.cmd("DBUIClose")
        end
      '';
      options = {
        silent = true;
        desc = "DBUI: Find Buffer and Connect";
      };
    }
  ];

  plugins.which-key.settings.spec = lib.optionals config.plugins.vim-dadbod.enable [
    {
      __unkeyed-1 = "<localleader>d";
      group = "Database";
      icon = "󰆼 ";
    }
  ];

  autoGroups = lib.mkIf config.plugins.vim-dadbod-ui.enable {
    vnix_database.clear = true;
  };

  autoCmd = [
    {
      event = "FileType";
      group = "vnix_database";
      pattern = [ "sql" "plsql" "mysql" ];
      callback = lib.nixvim.mkRaw ''
        function()
          local sql = require("sqls-simple-exec")
          local bufnr = vim.api.nvim_get_current_buf()

          vim.keymap.set({ "n", "v" }, "<CR>", sql.exec, {
            silent = true,
            buffer = bufnr,
            desc = "Execute query"
          })
        end
      '';
    }
  ]
  ++ lib.optionals config.plugins.vim-dadbod-ui.enable [
    {
      event = "FileType";
      group = "vnix_database";
      pattern = [ "sql" "plsql" "mysql" ];
      callback = lib.nixvim.mkRaw ''
        function()
          local sql = require("dadbod-simple-exec")
          local bufnr = vim.api.nvim_get_current_buf()

          vim.keymap.set({ "n", "v" }, "<localleader>d<CR>", sql.exec, {
            silent = true,
            buffer = bufnr,
            desc = "Execute query"
          })
        end
      '';
    }
  ];

  extraPackages = with pkgs; [
    sqruff
  ]
  ++ lib.optionals config.plugins.vim-dadbod.enable (with pkgs; [
    postgresql_17
  ]);
}
