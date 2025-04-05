{ pkgs, ... }:
{
  keymaps = [
    # --------------------------------------------------------------------------------
    # Cursor-Movement
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "H"; # shift-h
      action = "^<esc>";
      options = {
        desc = "Move cursor to the beginning of text";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "L"; # shift-l
      action = "$<esc>";
      options = {
        desc = "Move cursor to the end of text";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Cursor-Movement: Scroll
    # --------------------------------------------------------------------------------
    {
      mode = [
        "n"
        "x"
      ];
      key = "j";
      action = "v:count == 0 ? 'gjzz' : 'jzz'";
      options = {
        desc = "Scroll down and center page";
        silent = true;
        expr = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "k";
      action = "v:count == 0 ? 'gkzz' : 'kzz'";
      options = {
        desc = "Scroll up and center page";
        expr = true;
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Cursor-Movement: Jump Line
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "gg";
      action = "gg0";
      options.silent = true;
    }
    {
      mode = "n";
      key = "G";
      action = "Gzz0";
      options.silent = true;
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "{";
      action = "v:count == 0 ? '{zz0' : '{zz'";
      options.silent = true;
      options.expr = true;
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "}";
      action = "v:count == 0 ? '}zz0' : '}zz'";
      options.silent = true;
      options.expr = true;
    }
    {
      mode = "n";
      key = "(";
      action = "(zz0";
      options.silent = true;
    }
    {
      mode = "n";
      key = ")";
      action = ")zz0";
      options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # Indentation
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = ">"; # shift - >
      action = ">>_";
      options.silent = true;
    }
    {
      mode = "v";
      key = ">"; # shift - >
      action = ">gv";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<"; # shift - <
      action = "<<_";
      options.silent = true;
    }
    {
      mode = "v";
      key = "<"; # shift - <
      action = "<gv";
      options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # Comments
    # --------------------------------------------------------------------------------
    {
      mode = [
        "n"
        "i"
      ];
      key = "<C-_>"; # control-/
      action = "<esc>gcc<esc>";
      options = {
        desc = "Comment current line";
        silent = true;
        remap = true;
      };
    }
    {
      mode = [ "v" ];
      key = "<C-_>"; # control-/
      action = "gc<esc>";
      options = {
        desc = "Comment current line";
        silent = true;
        remap = true;
      };
    }
    {
      mode = "n";
      key = "gco";
      action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options = {
        desc = "Add Comment Below";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gcO";
      action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options = {
        desc = "Add Comment Above";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Search -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "n";
      action = "'Nn'[v:searchforward].'zzzv'";
      options = {
        expr = true;
        silent = true;
        desc = "Next Search Result";
      };
    }
    {
      mode = [
        "x"
        "o"
      ];
      key = "n";
      action = "'Nn'[v:searchforward]";
      options = {
        expr = true;
        silent = true;
        desc = "Next Search Result";
      };
    }
    {
      mode = "n";
      key = "N";
      action = "'nN'[v:searchforward].'zzzv'";
      options = {
        expr = true;
        silent = true;
        desc = "Prev Search Result";
      };
    }
    {
      mode = [
        "x"
        "o"
      ];
      key = "N";
      action = "'nN'[v:searchforward]";
      options = {
        expr = true;
        silent = true;
        desc = "Prev Search Result";
      };
    }

    # --------------------------------------------------------------------------------
    # Highlight Search
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<esc><esc>";
      action = ":nohlsearch<cr>zz";
      options = {
        desc = "Inactive highlighted search";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Insert Empty Line(s)
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<M-C-K>"; # Control-Alt-k
      action = "<S-o><esc>";
      options = {
        desc = "Insert empty line on the above of cursor and up";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<M-C-J>"; # Control-Alt-j
      action = "o<esc>";
      options = {
        desc = "Insert empty line on the below of cursor and down";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Duplicate Line(s)
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<M-K>"; # Alt-Shift-k
      action.__raw = ''
        function()
            local cursor = vim.fn.getpos(".") -- current cursor position
            vim.cmd("t.")
            vim.fn.setpos(".", cursor)
        end
      '';
      options = {
        desc = "Duplicate current line to above and up";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<M-J>"; # Alt-Shift-j
      action.__raw = ''
        function()
            local cursor = vim.fn.getpos(".") -- current cursor position
            local lineNumber = cursor[2]
            local column = cursor[3]
            vim.cmd("t.")
            vim.fn.setpos(".", { 0, lineNumber + 1, column, 0 })
        end
      '';
      options = {
        desc = "Duplicate current line into below and down";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Delete Char and Line(s) - skip register
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "x"; # cut: do not yank with x
      action = ''"_x'';
      options.silent = true;
    }
    {
      mode = "n";
      key = "D";
      action = ''"_D'';
      options.silent = true;
    }
    {
      mode = "n";
      key = "<M-d>"; # Alt-d
      action = ''"_dd<esc>'';
      options = {
        desc = "Delete current line";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<M-d>"; # Alt-d
      action = ''"_d<esc>'';
      options = {
        desc = "Delete selected line(s)";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Move Lines
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<A-j>";
      action = "<cmd>execute 'move .+' . v:count1<cr>==";
      options = {
        desc = "Move Down";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
      options = {
        desc = "Move Up";
        silent = true;
      };
    }
    {
      mode = "i";
      key = "<A-j>";
      action = "<esc><cmd>m .+1<cr>==gi";
      options = {
        desc = "Move Down";
        silent = true;
      };
    }
    {
      mode = "i";
      key = "<A-k>";
      action = "<esc><cmd>m .-2<cr>==gi";
      options = {
        desc = "Move Up";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
      options = {
        desc = "Move Down";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
      options = {
        desc = "Move Up";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Integrations
    # --------------------------------------------------------------------------------
    { mode = "n"; key = "<C-t>"; action = "<C-t>zz"; options.silent = true; }
    { mode = "n"; key = "<C-i>"; action = "<C-i>zz"; options.silent = true; }
    { mode = "n"; key = "<C-o>"; action = "<C-o>zz"; options.silent = true; }
    { mode = "n"; key = "<C-]>"; action = "<C-]>zz"; options.silent = true; }
  ];

  # --------------------------------------------------------------------------------
  # Quit by filetype
  # --------------------------------------------------------------------------------
  autoGroups.vnix_quit_filetype.clear = true;
  autoCmd = [
    {
      event = "FileType";
      group = "vnix_quit_filetype";
      pattern = [
        "dbout" # DBUI (dadbod-ui)
        "query" # InspectTree
        "gitsigns-blame" # Gitsigns blame
        "help" # help
      ];
      callback.__raw = ''
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          vim.keymap.set({ "n", "v" }, "q", ":bdelete<cr>", {
            silent = true,
            buffer = bufnr,
            desc = "Close buffer",
          })
        end
      '';
    }
  ];
}
