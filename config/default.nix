{ ... }:
{
  imports = [
    ./core
    ./coding
    ./editor
    ./ft
    ./ui
    ./extra
  ];

  plugins = {
    mini = {
      enable = true;
      # modules = { };
    };

    snacks = {
      enable = true;
    };

    snacks.settings = {
      bigfile = {
        enabled = true;
      };
      # quickfile = {
      #   enabled = false;
      # };
      # statuscolumn = {
      #   enabled = false;
      # };
      words = {
        debounce = 100;
        enabled = true;
      };
    };
  };

  autoCmd = [
    {
      event = [ "User" ];
      callback.__raw = ''
        function()
          -- Override print to use snacks for `:=` command
          vim.print = function(...)
            Snacks.debug.inspect(...)
          end
        end
      '';
    }
  ];
}
