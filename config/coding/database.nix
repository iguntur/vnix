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
  };

  globals = {
    db_ui_auto_execute_table_helpers = 1;
    db_ui_execute_on_save = false;
    db_ui_show_database_icon = true;
    db_ui_use_nerd_fonts = true;
    db_ui_use_nvim_notify = false;
    db_ui_save_location.__raw = "vim.fn.expand('${dataPath}')";
    db_ui_tmp_query_location.__raw = "vim.fn.expand('${dataPath}/tmp')";
  };

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
  ];

  extraPackages = lib.optionals config.plugins.vim-dadbod.enable (with pkgs; [
    postgresql_17
  ]);
}
