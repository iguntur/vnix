{ config, lib, ... }:
{
  plugins.sqlite-lua = {
    enable = true;
  };

  plugins.neoclip = {
    enable = true;
    settings = {
      enable_persistent_history = config.plugins.sqlite-lua.enable;
      keys = {
        fzf = {
          paste_behind = "ctrl-o";
        };
      };
    };
  };

  keymaps = lib.optionals config.plugins.neoclip.enable [
    {
      mode = "n";
      key = "<leader>s'";
      action = lib.nixvim.mkRaw "function() require('neoclip.fzf')() end";
      options.silent = true;
      options.desc = "Neoclip";
    }
  ];
}
