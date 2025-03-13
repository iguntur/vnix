{ pkgs, ... }:
{
  keymaps = [
    {
      mode = "t";
      key = "<C-c><C-x>";
      action = "<C-\\><C-n>";
      options.desc = "Normal mode";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<localleader><tab>\\";
      action.__raw = ''
        function()
          vim.cmd.tabnew()
          vim.cmd.terminal()
          vim.cmd.startinsert()
        end
      '';
      options.desc = "Open terminal on new tab";
      options.silent = true;
    }
  ];
}
