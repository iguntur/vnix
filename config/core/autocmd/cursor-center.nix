{ lib, pkgs, ... }:
let
  inherit (lib.nixvim) toLuaObject;

  ignore-filetypes = [
    "neo-tree"
    "NvimTree"
    "Outline"
    "aerial"
    "dbui"
    "undotree"
    "diff"
  ];

  ignore-buftypes = [
    "nofile"
    "prompt"
    "popup"
    "terminal"
  ];
in
{
  autoGroups = {
    vnix_cursor_center.clear = true;
  };

  autoCmd = [
    {
      event = [ "BufEnter" ];
      pattern = "*";
      group = "vnix_cursor_center";
      callback = lib.nixvim.mkRaw ''
        function()
          if vim.tbl_contains(${toLuaObject ignore-buftypes}, vim.bo.buftype) then
            return
          end

          vim.schedule(function()
            if (vim.fn.mode() ~= "n") then 
              return
            end

            vim.cmd("normal! zz")
          end)
        end
      '';
    }
  ];
}

