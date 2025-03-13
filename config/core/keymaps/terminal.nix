{ pkgs, ... }:
{
  keymaps = [
    {
      mode = "t";
      key = "<leader><esc>";
      action = "<C-\\><C-n>";
      options.desc = "Normal mode";
      options.silent = true;
    }
  ];
}
