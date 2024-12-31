{ pkgs, ... }:
let
  disableKeys = [
    "<up>"
    "<down>"
    "<left>"
    "<right>"
    "<space>"
  ];
in
{
  keymaps =
    (builtins.map (key: {
      inherit key;
      action = "<nop>";
      options.desc = "Disable Keys";
      options.silent = true;
    }) disableKeys)
    ++ [

    ];
}
