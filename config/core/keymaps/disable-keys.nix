{ pkgs, ... }:
let
  disableKeys = [
    "<up>"
    "<down>"
    "<left>"
    "<right>"
    "<space>"
    "<C-c>"
  ];
in
{
  keymaps = (builtins.map
    (key: {
      inherit key;
      action = "<nop>";
      options.desc = "Disable Keys";
      options.silent = true;
    })
    disableKeys)
  ++ [ ];
}
