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
    {
      mode = "n";
      key = "x"; # cut: do not yank with x
      action = ''"_x'';
      options.silent = true;
    }
    {
      mode = "n";
      key = "dw";
      action = ''viw"_d'';
      options.desc = "delete word from the end";
      options.silent = true;
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "p";
      action = ''"ap'';
      options.desc = "Paste from default editor clipboard";
      options.silent = true;
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "P";
      action = ''"aP'';
      options.desc = "Paste from default editor clipboard";
      options.silent = true;
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "D";
      action = ''"aD'';
      options.silent = true;
    }

    # {
    #   mode = [ "n" "v" ];
    #   key = "y";
    #   action = ''"ay'';
    #   options.desc = "Copy into default editor clipboard";
    #   options.silent = true;
    # }

    # {
    #   mode = [ "n" "v" ];
    #   key = "d";
    #   action = ''"ad'';
    #   options.silent = true;
    # }

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
