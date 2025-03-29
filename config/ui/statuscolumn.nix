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
    fold.__raw = "require('statuscol.builtin').foldfunc";
    linenumber = "%{v:lnum}";
    rel_linenumber = "%{v:relnum}";
    align_right = "%=";
    sign = "%s";
    space = " ";
    T = "%T";
    sign_or_pipe.__raw = ''
      function(args)
        local str_start_with = function(start_with, value)
          return value:sub(1, #start_with) == start_with
        end

        local get_sign = function(args)
          local bufnr = vim.api.nvim_get_current_buf()
          local signs = vim.fn.sign_getplaced(bufnr, {
            group = "*",
            lnum = args.lnum,
          })[1].signs

          local is_git_sign, is_diag_sign, is_mark_sign = false, false, false

          for _, sign in ipairs(signs) do
            local group = sign.group

            if str_start_with("gitsigns_", group) then
              is_git_sign = true
            elseif str_start_with("DiagnosticSign_", group) then
              is_diag_sign = true
            elseif str_start_with("MarkSign_", group) then
              is_mark_sign = true
            end
          end

          return {
            is_git_sign = is_git_sign,
            is_diag_sign = is_diag_sign,
            is_mark_sign = is_mark_sign,
          }
        end

        if get_sign(args).is_git_sign then
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
