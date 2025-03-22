{ pkgs, ... }:
{
  keymaps = [
    # --------------------------------------------------------------------------------
    # Replace
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<localleader>rw";
      action = ":%s/<C-r><C-w>/<C-r><C-w>/gI<left><left><left>";
      options.desc = "Replace word under cursor in entire buffer";
      # options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # Scratch RAW plugin
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<localleader><localleader>e";
      # action = "<cmd>edit ~/.config/nvim-plugin/init.lua<cr>";
      action = "<cmd>edit ~/dev/neovim-plugin/plugins.lua<cr>";
      options.desc = "Temporary write config plugins";
      options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # Sort Lines
    # --------------------------------------------------------------------------------
    {
      mode = "v";
      key = "<localleader>Sn";
      action = '':\'<,\'>!sort -f<cr><esc>'';
      options.desc = "Sort lines natural";
    }
    # {
    #   mode = "v";
    #   key = "<localleader>su";
    #   action = ":\'<,\'>!sort u<cr><esc>";
    #   options.desc = "Sort lines unique";
    # }

    {
      mode = "n";
      key = "<localleader><localleader>X";
      action = "<cmd>!chmod +x %<cr>";
      options.desc = "Set the current file into executable";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<localleader><localleader>$";
      action = "<cmd>put=system(getline('.'))<cr>";
      options.desc = "Execute current line to the system and put the results below";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<localleader><localleader>s";
      action = "<cmd>source %<cr>";
      options.desc = "Source the current file";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<localleader><localleader>h";
      action = "<cmd>checkhealth<cr>";
      options.desc = "Health Check";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<localleader><localleader>x";
      action = "<cmd>lua assert(load(vim.api.nvim_get_current_line()))()<cr>";
      options.desc = "Execute as :lua ... code";
      options.silent = true;
    }
  ];
}
