{ pkgs, ... }:
{
  keymaps = [
    # --------------------------------------------------------------------------------
    # Default register
    # --------------------------------------------------------------------------------
    {
      mode = "v";
      key = "p"; # paste
      action = ''"_dP'';
      options.desc = "Clipboard: paste but keep the 'yank' value";
      options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # System register
    # --------------------------------------------------------------------------------
    {
      mode = [
        "n"
        "v"
      ];
      key = "<localleader>y";
      action = ''"+y'';
      options.desc = "Copy into system clipboard";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<localleader>Y";
      action = ''"+Y'';
      options.desc = "Copy into system clipboard";
      options.silent = true;
    }
  ];
}
