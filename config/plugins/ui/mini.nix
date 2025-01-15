{ lib, pkgs, ... }:
{
  plugins = {
    # --------------------------------------------------------------------------------
    # Mini modules
    # --------------------------------------------------------------------------------
    mini.mockDevIcons = true;
    mini.modules = {
      icons.enable = true;

      indentscope = {
        # symbol = "▏";
        symbol = "│";
        options = {
          try_as_border = true;
        };
      };
    };
  };

  autoCmd = [
    # --------------------------------------------------------------------------------
    # Event: mini indent scope
    # --------------------------------------------------------------------------------
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
