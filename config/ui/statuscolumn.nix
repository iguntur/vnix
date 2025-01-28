{ ... }:
let

  icons = {
    # ┃, ┆, ┇, ┊, ┋, ╎, ╏, ║, ╽, ╿
    # pipe = "│ ";
    # pipe = "▎";
    pipe = "┃";
  };

  part = {
    diagnostic = "";
    fold = "%C";
    linenumber = "%l";
    rel_linenumber = "%r";
    align_right = "%=";
    sign = "%s";
    space = " ";
    T = "%T";
  };
in
{
  plugins = {
    statuscol = {
      enable = true;
      settings = {
        segments = [
          {
            text = [
              # part.fold
              { __raw = "require('statuscol.builtin').foldfunc"; }
              part.space
            ]; # fold
            click = "v:lua.ScFa";
          }
          {
            text = [
              part.linenumber
              part.space
            ]; # line_number
            click = "v:lua.ScLa";
          }
          {
            text = [
              part.align_right
              part.rel_linenumber
              part.space
            ]; # relative linenumber
            click = "v:lua.ScLa";
          }
          {
            text = [
              part.sign
              icons.pipe
            ]; # sign
            click = "v:lua.ScSa";
          }
          # {
          #   text = [ part.T ];
          #   # click = "v:lua.ScSa";
          # }
        ];
      };
    };

    snacks.settings.statuscolumn = {
      # enabled = true;
      enabled = false;
      # left = [];
      # right = [];
      # folds = { };
      # git = [ ];
    };
  };

  # opts = {
  #   statuscolumn.__raw = "[[%!v:lua.require('snacks.statuscolumn').get()]]";
  # };
}
