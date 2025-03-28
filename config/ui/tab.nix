{ pkgs, lib, vnix, ... }:
{
  extraConfigLuaPost = ''
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "TabLine", { bg = "none", fg = "darkgrey" })
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = "none", fg = "lightblue", bold = true })
  '';
}

