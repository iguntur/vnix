{ pkgs, ... }:
{
  autoGroups = {
    vnix_nopaste.clear = true;
    vnix_conceal.clear = true;
    vnix_spell.clear = true;
    vnix_highlight_yank.clear = true;
    vnix_terminal.clear = true;
    vnix_window.clear = true;
  };

  autoCmd = [
    {
      event = [ "InsertLeave" ];
      group = "vnix_nopaste";
      pattern = [ "*" ];
      command = "set nopaste";
    }
    {
      event = [ "FileType" ];
      group = "vnix_conceal";
      pattern = [
        "json"
        "jsonc"
        "json5"
        "markdown"
      ];
      callback.__raw = ''
        function()
          -- vim.wo.conceallevel = 0
          vim.opt_local.conceallevel = 0
        end
      '';
    }
    {
      event = [ "FileType" ];
      group = "vnix_spell";
      pattern = [
        "markdown"
        "text"
        "gitcommit"
        "json5"
        "jsonc"
      ];
      callback.__raw = ''
        function()
          vim.opt_local.spell = true
        end
      '';
    }
    {
      # Highlight on yank
      event = "TextYankPost";
      group = "vnix_highlight_yank";
      callback.__raw = ''
        function()
          (vim.hl or vim.highlight).on_yank()
        end
      '';
    }
    {
      # Terminal
      event = "TermOpen";
      group = "vnix_terminal";
      callback.__raw = ''
        function()
          vim.opt.number = false
          vim.opt.relativenumber = false
          vim.opt.laststatus = 3
          vim.opt.statuscolumn = ""
        end
      '';
    }
    {
      event = [ "WinEnter" "BufEnter" ];
      group = "vnix_window";
      callback.__raw = ''
        function()
          vim.opt.cursorline = true; -- enable highlighting of the current line
          vim.opt.cursorcolumn = true; -- enable highlighting of the current column
          vim.api.nvim_feedkeys("zz", "n", false)
        end
      '';
    }
    {
      event = [ "WinLeave" "BufLeave" ];
      group = "vnix_window";
      callback.__raw = ''
        function()
          vim.opt.cursorline = false;
          vim.opt.cursorcolumn = false;
          vim.api.nvim_feedkeys("zz", "n", false)
        end
      '';
    }
  ];
}
