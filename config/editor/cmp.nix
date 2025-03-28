{ config, pkgs, lib, ... }:
{
  plugins = {
    blink-compat = {
      enable = true;
      lazyLoad.settings.lazy = true;
    };

    blink-emoji.enable = true;
    blink-ripgrep.enable = true;
    # blink-cmp-git.enable = true;
    # blink-cmp-spell.enable = true;

    blink-cmp = {
      enable = true;
      lazyLoad.settings.event = [ "LspAttach" ];
      settings = {
        appearance = {
          use_nvim_cmp_as_default = true;
          nerd_font_variant = "mono";
        };

        fuzzy = {
          implementation = "prefer_rust_with_warning";
          # sorts = [
          #   # "exact"
          #   "score"
          #   "sort_text"
          #   # "kind"
          # ];
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

          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };

          menu = {
            draw = {
              treesitter = [ "lsp" ];
              columns = [
                { __unkeyed-1 = "source_name"; }
                {
                  __unkeyed-1 = "kind";
                  __unkeyed-2 = "kind_icon";
                  gap = 1;
                }
                {
                  __unkeyed-1 = "label";
                  # __unkeyed-2 = "label_description";
                  # gap = 1;
                }
              ];
            };
          };

          ghost_text = {
            enabled = true;
          };
        };

        signature = {
          enabled = true; # Experimental signature help support
        };

        snippets.preset = lib.optionals config.plugins.luasnip.enable "luasnip";

        cmdline = {
          enabled = true;
          sources.__raw = ''
            function()
              local type = vim.fn.getcmdtype()

              -- Search forward and backward
              if type == '/' or type == '?' then
                return { 'buffer' }
              end

              -- Commands
              if type == ':' or type == '@' then
                return { 'cmdline' }
              end

              return {}
            end
          '';
        };

        sources = rec {
          default = [ "lsp" "path" "snippets" "buffer" ] # built-in
            # community
            ++ lib.optionals config.plugins.blink-cmp-spell.enable [ "spell" ]
            ++ lib.optionals config.plugins.blink-emoji.enable [ "emoji" ]
            ++ lib.optionals config.plugins.blink-cmp-git.enable [ "git" ]
            ++ lib.optionals config.plugins.blink-ripgrep.enable [ "ripgrep" ]
            # ++ lib.optionals config.plugins.avante.enable [
            #   "avante_commands"
            #   "avante_files"
            #   "avante_mentions"
            # ]
            ++ [ ];
          per_filetype = {
            lua = if config.plugins.lazydev.enable then [ "lazydev" ] ++ default else default;
            markdown = if config.plugins.render-markdown.enable then default ++ [ "markdown" ] else default;
            sql = if config.plugins.vim-dadbod.enable then default ++ [ "dadbod" ] else default;
            mysql = if config.plugins.vim-dadbod.enable then default ++ [ "dadbod" ] else default;
            plsql = if config.plugins.vim-dadbod.enable then default ++ [ "dadbod" ] else default;
          };
          providers = {
            lsp = {
              fallbacks = [ "ripgrep" "buffer" ];
              score_offset = 0;
            };
            # path = { score_offset = 1; };
            # snippets = { score_offset = 2; };
            # buffer = { score_offset = 3; };
            emoji = lib.mkIf config.plugins.blink-emoji.enable {
              name = "Emoji";
              module = "blink-emoji";
              score_offset = 1;
            };
            ripgrep = lib.mkIf config.plugins.blink-ripgrep.enable {
              name = "Ripgrep";
              module = "blink-ripgrep";
              score_offset = 1;
            };
            lazydev = lib.mkIf config.plugins.lazydev.enable {
              name = "LazyDev";
              module = "lazydev.integrations.blink";
              # make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100;
            };
            git = lib.mkIf config.plugins.blink-cmp-git.enable {
              name = "Git";
              module = "blink-cmp-git";
              score_offset = 100;
            };
            spell = lib.mkIf config.plugins.blink-cmp-spell.enable {
              name = "Spell";
              module = "blink-cmp-spell";
              score_offset = 100;
            };
            markdown = lib.mkIf config.plugins.render-markdown.enable {
              name = "RenderMarkdown";
              module = "render-markdown.integ.blink";
              fallbacks = [ "lsp" ];
            };
            dadbod = lib.mkIf config.plugins.vim-dadbod.enable {
              name = "Dadbod";
              module = "vim_dadbod_completion.blink";
              score_offset = 10;
            };
          };
        };

        keymap = {
          preset = "default";
          "<Down>" = [ "select_next" "fallback" ];
          "<Up>" = [ "select_prev" "fallback" ];
        };
      };
    };

    lsp.capabilities =
      if (config.plugins.cmp-nvim-lsp.enable && config.plugins.blink-cmp.enable) then # lua
        ''
          capabilities = vim.tbl_deep_extend(
            "force",
            capabilities,
            require("cmp_nvim_lsp").default_capabilities(),
            require("blink.cmp").get_lsp_capabilities()
          )
        ''
      else if (config.plugins.cmp-nvim-lsp.enable) then # lua
        ''
          capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
        ''
      else if (config.plugins.blink-cmp.enable) then # lua
        ''
          capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
        ''
      else "";
  };

  extraPlugins = lib.mkIf config.plugins.blink-cmp.enable (with pkgs.vimPlugins; [
    # ...
  ]);
}
