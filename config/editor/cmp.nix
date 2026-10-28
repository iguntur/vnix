{ config, lib, pkgs, ... }:
let
  inherit (lib.nixvim) mkRaw;

  # Aman jika plugin tidak ada di versi NixVim yang dipakai.
  enabled = name: config.plugins.${name}.enable or false;

  # Tambahkan sumber ekstra di atas sources.default tanpa menyalin ulang default-nya.
  extend = extra:
    mkRaw "{ inherit_defaults = true, ${lib.concatMapStringsSep ", " (s: ''"${s}"'') extra} }";

  markdownExtras =
    lib.optional (enabled "render-markdown") "markdown"
    ++ lib.optional (enabled "blink-emoji") "emoji";

  sqlExtras = lib.optional (enabled "vim-dadbod") "dadbod";
in
{
  plugins = {
    blink-emoji.enable = true;
    blink-ripgrep.enable = true;

    blink-cmp = {
      enable = true;
      lazyLoad.settings.event = [ "InsertEnter" "CmdlineEnter" ];

      settings = {
        appearance = {
          # Hanya perlu jika colorscheme tidak menyediakan highlight group blink.
          use_nvim_cmp_as_default = true;
          nerd_font_variant = "mono";
        };

        completion = {
          accept.auto_brackets = {
            enabled = true;
            semantic_token_resolution.enabled = false;
          };

          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };

          ghost_text.enabled = true;

          menu.draw = {
            treesitter = [ "lsp" ];
            columns = [
              [ "source_name" ]
              { __unkeyed-1 = "kind_icon"; __unkeyed-2 = "kind"; gap = 1; }
              [ "label" ]
            ];
          };
        };

        signature.enabled = true;

        snippets.preset = "mini_snippets"; # butuh plugins.mini + modul snippets

        sources = {
          # default bawaan: lsp, path, snippets, buffer
          per_filetype =
            lib.optionalAttrs (enabled "lazydev") { lua = extend [ "lazydev" ]; }
            // lib.optionalAttrs (markdownExtras != [ ]) {
              markdown = extend markdownExtras;
              gitcommit = extend (lib.optional (enabled "blink-emoji") "emoji");
              text = extend (lib.optional (enabled "blink-emoji") "emoji");
            }
            // lib.optionalAttrs (sqlExtras != [ ]) (
              lib.genAttrs [ "sql" "mysql" "plsql" ] (_: extend sqlExtras)
            );

          providers =
            {
              # ripgrep hanya dipakai bila LSP tidak mengembalikan hasil
              lsp.fallbacks =
                lib.optional (enabled "blink-ripgrep") "ripgrep" ++ [ "buffer" ];
            }
            // lib.optionalAttrs (enabled "blink-emoji") {
              emoji = { name = "Emoji"; module = "blink-emoji"; score_offset = 1; };
            }
            // lib.optionalAttrs (enabled "blink-ripgrep") {
              ripgrep = { name = "Ripgrep"; module = "blink-ripgrep"; score_offset = 1; };
            }
            // lib.optionalAttrs (enabled "lazydev") {
              lazydev = {
                name = "LazyDev";
                module = "lazydev.integrations.blink";
                score_offset = 100;
              };
            }
            // lib.optionalAttrs (enabled "render-markdown") {
              markdown = {
                name = "RenderMarkdown";
                module = "render-markdown.integ.blink";
                fallbacks = [ "lsp" ];
              };
            }
            // lib.optionalAttrs (enabled "vim-dadbod") {
              dadbod = {
                name = "Dadbod";
                module = "vim_dadbod_completion.blink";
                score_offset = 10;
              };
            };
        };

        # keymap preset "default" sudah memuat <Up>/<Down>, <C-n>/<C-p>,
        # dan <Tab>/<S-Tab> untuk snippet jump.
        keymap.preset = "default";
      };
    };
  };

  extraPackages = lib.optional (enabled "blink-ripgrep") pkgs.ripgrep;
}
