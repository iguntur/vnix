{ config, lib, pkgs, vnix, ... }:
{
  plugins = {
    # --------------------------------------------------------------------------------
    # lualine
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
  };

  # extraPlugins = with pkgs.vimPlugins; [
  #   heirline-nvim
  # ];

  # extraConfigLua = ''
  #   do
  #     require("heirline").setup({})
  #   end
  # '';
}
