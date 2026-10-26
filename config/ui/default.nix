{ lib, pkgs, ... }:
{
  imports = [
    ./mini.nix
    ./snacks.nix
    ./statuscolumn.nix
    ./window.nix
    ./tab.nix
    ./statusline.nix
    ./csv.nix
    ./transparent.nix
  ];

  extraConfigLuaPost = ''
    vim.api.nvim_set_hl(0, "CursorColumn", {
      -- bg = "#101B17",
      bg = "None",
    })
    vim.api.nvim_set_hl(0, "CursorLine", {
      -- link = "CursorColumn",
      -- bg = "#181910",
      bg = "#101B17",
    })
    vim.api.nvim_set_hl(0, "Visual", { bg = "#F21F99" })
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
