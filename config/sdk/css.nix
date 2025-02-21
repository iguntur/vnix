{ config, lib, pkgs, ... }:
let
  tailwindcssRootPatterns = [
    "tailwind.config.js"
    "tailwind.config.cjs"
    "tailwind.config.mjs"
    "tailwind.config.ts"
    "postcss.config.js"
    "postcss.config.cjs"
    "postcss.config.mjs"
    "postcss.config.ts"
    "package.json"
  ];
  withPrefix = prefix: map (p: prefix + "/${p}") tailwindcssRootPatterns;
  allRootPatterns = [ ]
    ++ tailwindcssRootPatterns
    ++ (withPrefix "assets"); # phoenixframework uses assets
in
{
  plugins = {
    lsp.servers = {
      cssls.enable = true;
      tailwindcss = {
        enable = true;
        # https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/tailwindcss.lua
        rootDir.__raw = ''
          function(fname)
            return require("lspconfig.util").root_pattern(${
              lib.nixvim.toLuaObject allRootPatterns
            })(fname) or vim.fs.dirname(vim.fs.find('package.json', { path = fname, upward = true })[1]) or vim.fs.dirname(
              vim.fs.find('node_modules', { path = fname, upward = true })[1]
            ) or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
          end
        '';
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex";
              eelixir = "html-eex";
              heex = "html-eex";
              templ = "html";
            };
          };
        };
      };
    };

    tailwind-tools = {
      enable = config.plugins.lsp.servers.tailwindcss.enable;
    };

    conform-nvim.settings.formatters_by_ft = {
      # ...
    };
  };

  extraPackages = with pkgs; [
    rustywind # A tool for formatting Tailwind CSS classes.
  ];
}
