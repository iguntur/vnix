{ pkgs, lib, ... }:
let
  inherit (lib.nixvim) toLuaObject;

  settings = {
    xxx = { };
  };
in
{
  # extraPlugins = with pkgs.vimPlugins; [ ];
  # extraConfigLua = ''
  #   require("...").setup(${toLuaObject settings.xxx})
  # '';

  plugins = {
    treesitter = {
      enable = true;
      settings = { };
    };
  };

  # keymaps = [
  #   {
  #     mode = "n";
  #     key = "<leader>...";
  #     action = "<cmd>...<cr>";
  #     options = {
  #       silent = true;
  #       desc = "...";
  #     };
  #   }
  # ];
}
