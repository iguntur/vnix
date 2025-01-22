{ pkgs, ... }:
{
  plugins = {
    harpoon = {
      enable = true;
      # package = pkgs.vimPlugins.harpoon2;
      keymaps = { };
    };
  };
}
