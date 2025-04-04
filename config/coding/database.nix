{ config, lib, pkgs, ... }:
let
  dataPath = "$HOME/.local/resources/dadbod_ui";
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
  };

  globals = {
    db_ui_auto_execute_table_helpers = false;
    db_ui_execute_on_save = false;
    db_ui_disable_info_notifications = false;
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
          local sql = require("dadbod-simple-exec")
          local bufnr = vim.api.nvim_get_current_buf()

          vim.keymap.set({ "n", "v" }, "<CR>", sql.exec, {
            silent = true,
            buffer = bufnr,
            desc = "Execute query"
          })
        end
      '';
    }
  ];

  extraPackages = lib.optionals config.plugins.vim-dadbod.enable (with pkgs; [
    postgresql_17
  ]);
}
