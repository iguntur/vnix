{ pkgs, lib, vnix, ... }:
let
  inherit (lib.nixvim) toLuaObject;

  # Focus window
  ignore-filetypes = [
    "neo-tree"
    "NvimTree"
    "Outline"
    "aerial"
    "dbui"
    "undotree"
    "diff"
  ];

  ignore-buftypes = [
    "nofile"
    "prompt"
    "popup"
    "terminal"
  ];

  focus-settings = {
    autoresize = {
      enable = true; # Enable or disable auto-resizing of splits
      width = 140; # Force width for the focused window
      # height = 0; # Force height for the focused window
      # minwidth = 0; # Force minimum width for the unfocused window
      # minheight = 0; # Force minimum height for the unfocused window
      # height_quickfix = 10; # Set the height of quickfix panel
    };
    ui = {
      # number = false; # Display line numbers in the focussed window only
      # relativenumber = false; # Display relative line numbers in the focussed window only
      # hybridnumber = true; # Display hybrid line numbers in the focussed window only
      # absolutenumber_unfocussed = true; # Preserve absolute numbers in the unfocussed windows
      cursorline = false; # Display a cursorline in the focussed window only
      # cursorcolumn = true; # Display cursorcolumn in the focussed window only
      # colorcolumn = {
      #     enable = false; # Display colorcolumn in the foccused window only
      #     list = "+1"; # Set the comma-saperated list for the colorcolumn
      # };
      signcolumn = false; # Display signcolumn in the focussed window only
      # winhighlight = true; # Auto highlighting for focussed/unfocussed windows
    };
  };
in
{
  plugins = {
    # focus = { enable = true; settings = { }; };
    # windows = { enable = true; settings = { }; };
  };

  extraPlugins = with pkgs.vimPlugins; [
    focus-nvim # Auto-Focusing and Auto-Resizing Splits/Windows
    # windows-nvim # Automatically expand width of the current window. Maximizes and restore it.
  ];

  extraConfigLua = vnix.lua.mkRequire' "focus" "setup" focus-settings;

  autoGroups = {
    vnix_statuscolumn.clear = true;
    FocusEnable.clear = true;
    FocusDisable.clear = true;
  };

  autoCmd = [
    {
      desc = "Disable autoresize window for FileType";
      event = [ "FileType" ];
      group = "FocusDisable";
      callback = lib.nixvim.mkRaw ''
        function(_)
          if vim.tbl_contains(${toLuaObject ignore-filetypes}, vim.bo.filetype) then
            vim.b.focus_disable = true
          else
            vim.b.focus_disable = false
          end
        end
      '';
    }
    {
      desc = "Disable autoresize window for BufType";
      event = [ "WinEnter" ];
      group = "FocusDisable";
      callback = lib.nixvim.mkRaw ''
        function(_)
          if vim.tbl_contains(${toLuaObject ignore-buftypes}, vim.bo.buftype) then
            vim.w.focus_disable = true
          else
            vim.w.focus_disable = false
          end
        end
      '';
    }

    {
      event = [
        "FileType"
        "BufEnter"
      ];
      group = "vnix_statuscolumn";
      callback = lib.nixvim.mkRaw ''
        function()
          if vim.tbl_contains(${toLuaObject ignore-filetypes}, vim.bo.filetype) then
            vim.wo.statuscolumn = ""
          end
        end
      '';
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>wf";
      action.__raw = "require('focus').focus_autoresize";
      options = {
        silent = true;
        desc = "Window Focus";
      };
    }
    {
      mode = "n";
      key = "<leader>ws";
      action.__raw = "require('focus').split_nicely";
      options = {
        silent = true;
        desc = "Window Split Nicely";
      };
    }
  ];
}
