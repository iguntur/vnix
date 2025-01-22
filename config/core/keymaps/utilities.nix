{ pkgs, ... }:
{
  keymaps = [
    # --------------------------------------------------------------------------------
    # Replace
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<localleader>rw";
      action = '':%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<left><left><left>'';
      options.desc = "Replace word under cursor in entire buffer";
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
      key = "<localleader><localleader>x";
      action = "<cmd>!chmod +x %<cr>";
      options.desc = "Set the current file into executable";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<localleader><localleader>$";
      action = "<cmd>put=system(getline('.'))<cr>";
      options.desc = "Execute current line and put the results below";
      options.silent = true;
    }

  ];
}
