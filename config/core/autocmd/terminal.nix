{ lib, pkgs, ... }:
{
  autoGroups = {
    vnix_terminal.clear = true;
  };

  autoCmd = [
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
  ];
}

