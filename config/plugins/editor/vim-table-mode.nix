{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    vim-table-mode # VIM Table Mode for instant table creation.
  ];

  # extraConfigLua = ''
  #   -- ...
  # '';

  # keymaps = [
  #   {
  #     mode = "n";
  #     key = "<localleader><localleader>uT";
  #     action = "<cmd>TableModeToggle<cr>";
  #     options.silent = true;
  #     options.desc = "Toggle Table Creation";
  #   }
  # ];
}
