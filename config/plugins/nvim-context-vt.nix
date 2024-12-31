{ pkgs, lib, ... }:
let
  inherit (lib.nixvim) toLuaObject;

  settings = {
    context_vt = {
      # Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
      # Default: true
      enabled = false;

      # Override default virtual text prefix
      # Default: '#>'
      prefix = "";
    };
  };
in
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim_context_vt # Nvim Context VT: end of context line or scope
  ];

  extraConfigLua = ''
    require("nvim_context_vt").setup(${toLuaObject settings.context_vt})
  '';

  keymaps = [
    {
      mode = "n";
      key = "<localleader><localleader>uC";
      action = "<cmd>NvimContextVtToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle Context VT";
      };
    }
  ];
}
