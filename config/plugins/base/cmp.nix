{ pkgs, ... }:
{
  plugins = {
    blink-cmp = {
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
        sources = {
          cmdline = [ ];
          default = [
            "lazydev"
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
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
  };
}
