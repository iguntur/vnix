{ config, lib, pkgs, ... }:
let
  dataPath = "$HOME/.local/share/dadbod_ui";
in
{
  plugins = {
    vim-dadbod = {
      enable = true;
    };

    vim-dadbod-ui = {
      enable = config.plugins.vim-dadbod.enable;
    };

    vim-dadbod-completion = {
      enable = config.plugins.vim-dadbod.enable;
    };

    fzf-lua.keymaps = {
      "<localleader>df" = {
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
  };

  globals = {
    db_ui_auto_execute_table_helpers = false;
    db_ui_execute_on_save = false;
    db_ui_disable_info_notifications = true;
    db_ui_show_database_icon = true;
    db_ui_use_nerd_fonts = true;
    db_ui_use_nvim_notify = true;
    db_ui_save_location.__raw = "vim.fn.expand('${dataPath}')";
    db_ui_tmp_query_location.__raw = "vim.fn.expand('${dataPath}/tmp')";
  };

  extraConfigLuaPost = ''
    vim.api.nvim_set_hl(0, "NotificationInfo", { bg = "None" }) -- DBUI Notifications
  '';

  keymaps = lib.optionals config.plugins.vim-dadbod.enable [
    {
      mode = "n";
      key = "<localleader>db";
      action = "<cmd>DBUIToggle<cr>";
      options = {
        silent = true;
        desc = "DBUI Toggle";
      };
    }
    {
      mode = "n";
      key = "<localleader>dh";
      action = "<cmd>DBUIHideNotifications<cr>";
      options = {
        silent = true;
        desc = "DBUI Hide Notifications";
      };
    }
    {
      mode = "n";
      key = "<localleader>ds";
      action.__raw = ''
        function()
          vim.cmd("DBUIFindBuffer")
          vim.cmd("DBUIClose")
        end
      '';
      options = {
        silent = true;
        desc = "DBUI Find/Search Buffer";
      };
    }
  ];

  autoGroups = lib.optionals config.plugins.vim-dadbod.enable {
    vnix_database.clear = true;
  };

  autoCmd = lib.optionals config.plugins.vim-dadbod.enable [
    {
      event = "FileType";
      group = "vnix_database";
      pattern = [ "sql" "plsql" "mysql" ];
      callback.__raw = ''
        function()
          local map = function(mode, lhs, rhs, opts)
            local bufnr = vim.api.nvim_get_current_buf()
            opts = opts or {}
            opts = vim.tbl_deep_extend("force", { silent = true }, opts, { buffer = bufnr })
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          map({ "n", "v" }, "<CR>", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute query" })
        end
      '';
    }
    {
      event = "FileType";
      group = "vnix_database";
      pattern = [ "dbout" ];
      callback.__raw = ''
        function()
          local map = function(mode, lhs, rhs, opts)
            local bufnr = vim.api.nvim_get_current_buf()
            opts = opts or {}
            opts = vim.tbl_deep_extend("force", { silent = true }, opts, { buffer = bufnr })
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          map({ "n", "v" }, "q", ":bdelete<cr>", { desc = "Close buffer (dbout)" })
        end
      '';
    }
  ];

  extraPackages = lib.optionals config.plugins.vim-dadbod.enable (with pkgs; [
    postgresql_17
  ]);
}
