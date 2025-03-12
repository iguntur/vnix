{ ... }:
{
  keymaps = [
    # --------------------------------------------------------------------------------
    # Buffer: write or save
    # --------------------------------------------------------------------------------
    {
      mode = [
        "n"
        "v"
      ];
      key = "<C-s>";
      action = "<esc>:w<cr><esc>";
      options.desc = "Write or saving current buffer";
      options.silent = true;
    }
    {
      mode = "i";
      key = "<C-s>";
      action = "<esc>:w<cr><esc>a";
      options.desc = "Write or saving current buffer";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-c><C-s>"; # ctrl-c ctrl-s
      action = "<esc>:wa<cr><esc>";
      options.desc = "Write or saving all buffers";
      options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # Buffer: exit or close buffer
    # --------------------------------------------------------------------------------
    # {
    #   mode = "n";
    #   key = "<M-w>"; # Alt-w
    #   action = ":bdelete<cr>";
    #   options.desc = "Close current buffer and window";
    #   options.silent = true;
    # }
    {
      mode = "n";
      key = "<leader>bd"; # Alt-w
      action = ":bdelete<cr>";
      options.desc = "Close current buffer and window";
      options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # Buffer switch
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>`";
      action = "<cmd>e #<cr>";
      options.desc = "Switch to last accessed buffer";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-M-l>";
      action = "<cmd>bnext<cr>";
      options.desc = "Next Buffer";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<C-M-h>";
      action = "<cmd>bprevious<cr>";
      options.desc = "Previous Buffer";
      options.silent = true;
    }
  ];
}
