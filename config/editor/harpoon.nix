{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    harpoon2
  ];

  extraConfigLua = ''
    do
      local harpoon = require("harpoon")

      harpoon:setup() -- REQUIRED

      vim.keymap.set("n", "<C-c>h", function()
        harpoon:list():add()
        vim.cmd.normal({ "zz", bang = true })
      end, { silent = true, desc = "Add to harpoon list" })

      vim.keymap.set("n", "<C-c>H", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { silent = true, desc = "Harpoon list" })

      for i = 1, 6 do
        vim.keymap.set("n", "<localleader>" .. i, function() 
          harpoon:list():select(i)
          vim.cmd.normal({ "zz", bang = true })
        end, { silent = true, desc = "Harpoon target " .. i })
      end

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-M-h>", function()
        harpoon:list():prev()
        vim.cmd.normal({ "zz", bang = true })
      end, { silent = true, desc = "Previous harpoon target" })

      vim.keymap.set("n", "<C-M-l>", function()
        harpoon:list():next()
        vim.cmd.normal({ "zz", bang = true })
      end, { silent = true, desc = "Next harpoon target" })
    end
  '';
}
