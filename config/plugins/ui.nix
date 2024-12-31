{ config, pkgs, ... }:
{
  plugins = {
    # web-devicons.enable = true;

    mini.modules = {
      icons = {
        enable = true;
      };
      indentscope = {
        # symbol = "▏";
        symbol = "│";
        options = {
          try_as_border = true;
        };
      };
    };

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
  };

  autoCmd = [
    {
      event = [ "FileType" ];
      callback.__raw = ''
        function()
          vim.b.miniindentscope_disable = true
        end 
      '';
      pattern = [
        "NvimTree"
        "Trouble"
        "alpha"
        "dashboard"
        "fzf"
        "help"
        "mason"
        "neo-tree"
        "notify"
        "snacks_dashboard"
        "snacks_notif"
        "snacks_terminal"
        "snacks_win"
        "toggleterm"
        "trouble"
      ];
    }
  ];
}
