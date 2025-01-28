{ lib, pkgs, ... }:
{
  plugins = {
    # mini.modules = {
    #   files = {
    #     # General options
    #     options = {
    #       permanent_delete = false; # Whether to delete permanently or move into module-specific trash
    #       use_as_default_explorer = true; # Whether to use for editing directories
    #     };
    #
    #     # TODO: would be great if having this actions instead of manual define mappings.
    #     # mappings = {
    #     #   vertical = "<C-v>";
    #     #   horizontal = "<C-s>";
    #     #   hidden = "g."; # toggle hidden files
    #     # };
    #
    #     # Customization of explorer windows
    #     windows = {
    #       max_number.__raw = "math.huge"; # Maximum number of windows to show side by side
    #       preview = true; # Whether to show preview of file/directory under cursor
    #       width_focus = 25; # Width of focused window
    #       width_nofocus = 15; # Width of non-focused window
    #       width_preview = 80; # Width of preview window
    #     };
    #   };
    # };

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
          "<localleader>|" = {
            __unkeyed-1 = "actions.select";
            opts.vertical = true;
          };
          "<localleader>-" = {
            __unkeyed-1 = "actions.select";
            opts.horizontal = true;
          };
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
    # Mini files
    # {
    #   mode = "n";
    #   key = "<leader>fm";
    #   action = ":lua MiniFiles.open(vim.fn.expand('%:h'))<cr>";
    #   options = {
    #     silent = true;
    #     desc = "Mini File Manager (Relative Working File)";
    #   };
    # }
    # {
    #   mode = "n";
    #   key = "<leader>fM";
    #   action = ":lua MiniFiles.open()<cr>";
    #   options = {
    #     silent = true;
    #     desc = "Mini File Manager (cwd)";
    #   };
    # }

    # Oil
    {
      mode = "n";
      key = "<leader>f-";
      action = "<cmd>Oil<cr>";
      options = {
        silent = true;
        desc = "Open Oil at the current file";
      };
    }

    # Yazi
    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>Yazi<cr>";
      options = {
        silent = true;
        desc = "Open Yazi at the current file";
      };
    }
    {
      mode = "n";
      key = "<leader>fE";
      action = "<cmd>Yazi cwd<cr>";
      options = {
        silent = true;
        desc = "Open Yazi (cwd)";
      };
    }
    {
      mode = "n";
      key = "<leader>f<Up>";
      action = "<cmd>Yazi toggle<cr>";
      options = {
        silent = true;
        desc = "Resume the last Yazi session";
      };
    }
  ];
}
