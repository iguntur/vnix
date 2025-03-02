{ config, lib, pkgs, ... }:
let
  inherit (lib.nixvim) toLuaObject;
  tailwindcssRootPatterns = [
    "tailwind.config.js"
    "tailwind.config.cjs"
    "tailwind.config.mjs"
    "tailwind.config.ts"
    "postcss.config.js"
    "postcss.config.cjs"
    "postcss.config.mjs"
    "postcss.config.ts"
  ];
  withPrefix = prefix: map (p: prefix + "/${p}") tailwindcssRootPatterns;
in
{
  plugins = {
    lsp.servers = {
      cssls.enable = true;
      tailwindcss = {
        enable = true;
        # https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/tailwindcss.lua
        # rootDir.__raw = ''
        #   function(fname)
        #     if vim.loop.fs_stat("mix.exs") or vim.loop.fs_stat("mix.lock") then
        #       local patterns = ${toLuaObject (withPrefix "assets")}
        #       local cwd = vim.uv.cwd()
        #
        #       for _, fp in ipairs(patterns) do
        #         if vim.loop.fs_stat(cwd .. "/" .. fp) then
        #           return vim.fn.fnamemodify(cwd .. "/" .. fp, ":h")
        #         end
        #       end
        #     end
        #
        #     return require("lspconfig.config.tailwindcss").default_config.root_dir(fname)
        #   end
        # '';
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
