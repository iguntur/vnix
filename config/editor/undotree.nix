{ ... }:
{
  plugins.undotree = {
    enable = true;
    settings = {
      # DiffAutoOpen = true;
      # SetFocusWhenToggle = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<localleader>u";
      action = "<cmd>UndotreeToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle Undotree";
      };
    }
  ];
}
