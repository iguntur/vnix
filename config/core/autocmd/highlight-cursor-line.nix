{ lib, pkgs, ... }:
{
  autoGroups = {
    vnix_highlight_cursor_line.clear = true;
  };

  autoCmd = [
    {
      event = [ "WinEnter" "BufEnter" ];
      group = "vnix_highlight_cursor_line";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.opt.cursorline = true; -- enable highlighting of the current line
          vim.opt.cursorcolumn = true; -- enable highlighting of the current column
        end
      '';
    }
    {
      event = [ "WinLeave" "BufLeave" ];
      group = "vnix_highlight_cursor_line";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.opt.cursorline = false;
          vim.opt.cursorcolumn = false;
        end
      '';
    }
  ];
}

