{ pkgs, lib, ... }:
let
  # inherit (lib.nixvim) toLuaObject;
in
{
  # extraPlugins = with pkgs.vimPlugins; [ ];
  # extraConfigLua = ''
  #   require("...").setup(${toLuaObject settings.xxx})
  # '';

  plugins = {
    transparent = {
      enable = true;
      # settings = { };
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
