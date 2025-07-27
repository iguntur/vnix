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
    {
      mode = "n";
      key = "<localleader><tab>v";
      action.__raw = ''
        function()
          local dir = vim.fn.expand("%:p:h")
          vim.cmd.vnew()
          vim.cmd.edit("term://" .. dir .. "//fish")
          vim.cmd.startinsert()
        end
      '';
      options.desc = "Open terminal on current directory (vertical split)";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<localleader><tab>s";
      action.__raw = ''
        function()
          local dir = vim.fn.expand("%:p:h")
          vim.cmd.new()
          vim.cmd.edit("term://" .. dir .. "//fish")
          vim.cmd.startinsert()
        end
      '';
      options.desc = "Open terminal on current directory (horizontal split)";
      options.silent = true;
    }
  ];
}
