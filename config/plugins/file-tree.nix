{ config, pkgs, ... }:
{
  plugins = {
    oil = {
      enable = true;
      settings = {
        columns = [
          # "type"
          "permissions"
          "size"
          "icon"
        ];
        keymaps = {
          "<C-l>" = false;
          "<C-s>" = false;
          "<C-h>" = false;
          "<C-r>" = "actions.refresh";
          "y." = "actions.copy_entry_path";
          "<localleader>|".__raw = ''
            { "actions.select", opts = { vertical = true } }
          '';
          "<localleader>-".__raw = ''
            { "actions.select", opts = { horizontal = true } }
          '';
        };
        skip_confirm_for_simple_edits = true;
        view_options = {
          show_hidden = true;
        };
        # win_options = {
        #   concealcursor = "ncv";
        # };
      };
    };

    yazi = {
      enable = true;
      settings = {
        # enable_mouse_support = true;
        # floating_window_scaling_factor = 0.5;
        # log_level = "debug";
        open_for_directories = true;
        # yazi_floating_window_border = "single";
        # yazi_floating_window_winblend = 50;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader><leader>o";
      action = "<cmd>Oil<cr>";
      options = {
        silent = true;
        desc = "Open Oil at the current file";
      };
    }
    {
      mode = "n";
      key = "<leader><leader>-";
      action = "<cmd>Yazi<cr>";
      options = {
        silent = true;
        desc = "Open Yazi at the current file";
      };
    }
    {
      mode = "n";
      key = "<leader><leader><Up>";
      action = "<cmd>Yazi toggle<cr>";
      options = {
        silent = true;
        desc = "Resume the last yazi session";
      };
    }
  ];
}
