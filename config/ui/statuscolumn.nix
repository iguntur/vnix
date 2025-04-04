{ ... }:
let

  icons = {
    # ┃, ┆, ┇, ┊, ┋, ╎, ╏, ║, ╽, ╿
    pipe = "│";
    # pipe = "▎";
    # pipe = "┃";
  };

  part = {
    diagnostic = "";
    # fold = "%C";
    # fold.__raw = "require('statuscol.builtin').foldfunc";
    fold = "%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? '' : '󰡍') : ' '}";
    linenumber = "%{v:lnum}";
    rel_linenumber = "%{v:relnum}";
    align_right = "%=";
    sign = "%s";
    space = " ";
    T = "%T";
    sign_or_pipe.__raw = ''
      function(args)
        local function get_sign(pattern, opts)
          opts = opts or {}
          local lnum = opts.lnum or vim.v.lnum

          local bufnr = vim.api.nvim_get_current_buf()
          local signs = vim.fn.sign_getplaced(bufnr, {
            group = "*",
            lnum = lnum,
          })[1].signs or {}

          for _, sign in ipairs(signs) do
            -- Match group or name against the pattern
            if sign.group:match(pattern) then
              return sign
            end
          end

          return nil
        end

        local sign = get_sign("^[a-zA-Z]")
        if sign then
          return "%s"
        end

        return "${icons.pipe} %#"
      end,
    '';
  };
in
{
  plugins = {
    statuscol = {
      enable = true;
      settings = {
        segments = [
          {
            text = [ part.fold ]; # fold
            click = "v:lua.ScFa";
          }
          {
            text = [
              part.space
              part.linenumber
            ]; # line_number
            click = "v:lua.ScLa";
          }
          {
            text = [
              part.space
              part.align_right
              part.rel_linenumber
            ]; # relative linenumber
            click = "v:lua.ScLa";
          }
          {
            text = [
              part.space
              part.sign_or_pipe
            ]; # sign
            # click = "v:lua.ScSa";
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
