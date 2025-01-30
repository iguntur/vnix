{ config, pkgs, lib, ... }:
{
  plugins.blink-cmp = {
    enable = true;
    settings = {
      appearance = {
        use_nvim_cmp_as_default = false;
        nerd_font_variant = "mono";
      };

      completion = {
        accept = {
          auto_brackets = {
            enabled = true;
            semantic_token_resolution = {
              enabled = false;
            };
          };
        };
        menu = {
          draw = {
            columns = [
              {
                __unkeyed-1 = "label";
              }
              {
                __unkeyed-1 = "kind_icon";
                __unkeyed-2 = "kind";
                gap = 1;
              }
              { __unkeyed-1 = "source_name"; }
            ];
            treesitter = [ "lsp" ];
          };
        };
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };
        ghost_text = {
          enabled = true;
        };
      };

      signature = {
        enabled = true; # Experimental signature help support
      };

      # snippets.preset = "mini_snippets";
      snippets.preset = "luasnip";

      sources = {
        cmdline = [ ];
        default = [
          # built-in
          "lsp"
          "path"
          "snippets"
          "buffer"

          # community
          "lazydev"
          "emoji"
          "ripgrep"
        ];
        # ++ lib.optionals config.plugins.avante.enable [
        #   "avante_commands"
        #   "avante_files"
        #   "avante_mentions"
        # ];
        providers = {
          lazydev = {
            name = "LazyDev";
            module = "lazydev.integrations.blink";
            # make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100;
          };
          buffer = {
            score_offset = -7;
          };
          lsp = {
            fallbacks = [ ];
            # score_offset = 4;
          };
          emoji = {
            name = "Emoji";
            module = "blink-emoji";
            score_offset = 1;
          };
          ripgrep = {
            name = "Ripgrep";
            module = "blink-ripgrep";
            score_offset = 1;
          };
        };
      };

      keymap = {
        preset = "default";
        "<Down>" = [
          "select_next"
          "fallback"
        ];
        "<Up>" = [
          "select_prev"
          "fallback"
        ];
      };
    };
  };

  plugins.lsp.capabilities = lib.optionals config.plugins.blink-cmp.enable # lua
    ''
      capabilities = vim.tbl_deep_extend( "force", capabilities, require('blink.cmp').get_lsp_capabilities())
    '';

  extraPlugins = lib.mkIf config.plugins.blink-cmp.enable (with pkgs.vimPlugins; [
    blink-emoji-nvim
    blink-ripgrep-nvim
  ]);
}
