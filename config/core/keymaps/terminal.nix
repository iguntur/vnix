{ pkgs, ... }:
{
  keymaps = [
    {
      mode = "t";
      key = "<C-c><C-x>";
      action = "<C-\\><C-n>";
      options.desc = "Normal mode";
      options.silent = true;
    }
  ];
}
