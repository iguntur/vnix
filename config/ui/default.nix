{ lib, pkgs, ... }:
{
  imports = [
    ./mini.nix
    ./snacks.nix
    ./statuscolumn.nix
    ./window.nix
    ./tab.nix
  ];

  plugins = {
    # web-devicons.enable = true;

    # notify = {
    #   enable = true;
    #   backgroundColour = "#000000";
    # };

    # --------------------------------------------------------------------------------
    # statusline
    # --------------------------------------------------------------------------------
    lualine = {
      enable = true;
      settings = {
        options = {
          extensions = [
            "aerial"
            "fzf"
            "nvim-dap-ui"
            "oil"
            "overseer"
            "quickfix"
            "trouble"
          ];
          section_separators = {
            left = "";
            right = "";
          };
          component_separators = {
            left = "";
            right = "";
          };
        };
      };
    };

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
