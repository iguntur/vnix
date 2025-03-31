{ lib, pkgs, ... }:
{
  imports = [
    ./mini.nix
    ./snacks.nix
    ./statuscolumn.nix
    ./window.nix
    ./tab.nix
    ./statusline.nix
  ];

  extraConfigLuaPost = ''
    vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#181910" })
    vim.api.nvim_set_hl(0, "CursorLine", { link = "CursorColumn" })
    vim.api.nvim_set_hl(0, "Visual", { bg = "#181835" })
  '';

  plugins = {
    # web-devicons.enable = true;

    # notify = {
    #   enable = true;
    #   backgroundColour = "#000000";
    # };

    # --------------------------------------------------------------------------------
    # winbar
    # --------------------------------------------------------------------------------
    barbecue = {
      enable = true;
      settings = {
        show_modified = true; # whether to replace file icon with the modified symbol when buffer is modified.
      };
    };

    fidget = {
      enable = true;
      settings = { };
    };
  };
}
