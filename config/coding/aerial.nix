{ lib, pkgs, ... }:
{
  plugins = {
    aerial = {
      enable = true;
      settings = {
        show_guides = true;
        highlight_on_hover = true;
        attach_mode = "global";
        default_direction = "prefer_left";
        backends = [
          "lsp"
          "treesitter"
          "markdown"
          "man"
        ];
        layout = {
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB";
            signcolumn = "yes";
            statuscolumn = " ";
          };
        };
        on_attach.__raw = ''
          function(bufnr)
            vim.keymap.set("n", "(", "<cmd>AerialPrev<cr>", { buffer = bufnr, silent = true, desc = "Prev Symbol" })
            vim.keymap.set("n", ")", "<cmd>AerialNext<cr>", { buffer = bufnr, silent = true, desc = "Next Symbol" })
          end
        '';
      };
    };
  };
}
