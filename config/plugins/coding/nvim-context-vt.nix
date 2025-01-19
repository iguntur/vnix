{
  pkgs,
  lib,
  vnix,
  ...
}:
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim_context_vt # Nvim Context VT: end of context line or scope
  ];

  extraConfigLua = vnix.lua.mkRequire' "nvim_context_vt" "setup" {
    # Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
    # Default: true
    enabled = false;

    # Override default virtual text prefix
    # Default: '#>'
    prefix = "";
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>uC";
      action = "<cmd>NvimContextVtToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle Context VT";
      };
    }
  ];
}
