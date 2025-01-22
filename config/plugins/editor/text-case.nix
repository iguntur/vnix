{ pkgs, vnix, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    text-case-nvim # An all in one plugin for converting text case in Neovim (https://github.com/johmsalas/text-case.nvim)
  ];

  extraConfigLua = vnix.lua.mkRequire' "textcase" "setup" {
    # Set `default_keymappings_enabled` to false if you don't want automatic keymappings to be registered.
    # default_keymappings_enabled = true;

    # `prefix` is only considered if `default_keymappings_enabled` is true. It configures the prefix
    # of the keymappings, e.g. `gau ` executes the `current_word` method with `to_upper_case`
    # and `gaou` executes the `operator` method with `to_upper_case`.
    prefix = "<localleader>t"; # default: ga
  };

  extraConfigLuaPost = vnix.lua.mkRequire' "which-key" "add" [
    {
      __unkeyed-1 = "<localleader>t";
      group = "Text Case";
      icon = "󱄽 ";
    }
  ];
}
