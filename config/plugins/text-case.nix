{ config, pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    text-case-nvim # An all in one plugin for converting text case in Neovim
  ];

  extraConfigLua = ''
    require("textcase").setup()
  '';

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
