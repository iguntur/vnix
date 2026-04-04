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
          theme = "powerline_dark"; # auto, nord, powerline, powerline_dark
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
            # left = "";
            # right = "";
            left = "";
            right = "";
          };
          component_separators = "";
          # component_separators = { left = ""; right = ""; };
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
