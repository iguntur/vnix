{ pkgs, ... }:
{
  keymaps = [
    # --------------------------------------------------------------------------------
    # Window
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>w-";
      action = "<C-w>s";
      options = {
        desc = "Split window below";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>w|";
      action = "<C-w>v";
      options = {
        desc = "Split window right";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wq";
      action = "<C-w>c";
      options = {
        desc = "[w]indow [q]uit";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Window: Move window
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Go to Left Window";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Go to Lower Window";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Go to Upper Window";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Go to Right Window";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Window: Resize window (Ctrl-<Arrow_Keys>)
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<C-Up>";
      action = ":resize +5<cr>";
      options.silent = true;
      options.desc = "Increase window height";
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = ":resize -5<cr>";
      options.silent = true;
      options.desc = "Decrease window height";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = ":vertical resize +5<cr>";
      options.silent = true;
      options.desc = "Increase window width";
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = ":vertical resize -5<cr>";
      options.silent = true;
      options.desc = "Decrease window width";
    }
  ];
}
