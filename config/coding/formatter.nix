{ pkgs, lib, ... }:
{
  globals = {
    slow_format.__raw = "{}";
  };

  opts = {
    formatexpr = "v:lua.require('conform').formatexpr()";
  };

  plugins = {
    # --------------------------------------------------------------------------------
    # LSP Format
    # --------------------------------------------------------------------------------
    # lsp-format = {
    #   enable = true;
    #   settings = { };
    # };

    # --------------------------------------------------------------------------------
    # Conform
    # --------------------------------------------------------------------------------
    conform-nvim = {
      enable = true;
      settings = {
        # log_level = "warn"; # default: error
        # notify_on_error = false;
        # notify_no_formatters = false;
        default_format_opts = {
          timeout_ms = 3000;
          async = false; # not recommended to change
          quiet = false; # not recommended to change
          lsp_format = "fallback"; # not recommended to change
        };
        formatters_by_ft = {
          # Use the "*" filetype to run formatters on all filetypes.
          # "*" = [ "codespell" ];

          # Use the "_" filetype to run formatters on filetypes that don't
          # have other formatters configured.
          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
          json = {
            __unkeyed-1 = "biome-check";
            __unkeyed-2 = "prettierd";
            __unkeyed-3 = "prettier";
            timeout_ms = 2000;
            stop_after_first = true;
          };
        };
        formatters = {
          injected = {
            options = {
              ignore_errors = true;
            };
          };
          squeeze_blanks.command = lib.getExe' pkgs.coreutils "cat";
        };
        format_on_save = /* lua */ ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if vim.g.slow_format[bufnr] then
              return
            end

            local function on_format(err)
              if err and err:match("timeout$") then
                vim.g.slow_format[bufnr] = true
              end
            end

            return { timeout_ms = 500, lsp_fallback = true }, on_format
          end
        '';
        format_after_save = /* lua */ ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if not vim.g.slow_format[bufnr] then
              return
            end

            return { lsp_fallback = true }
          end
        '';
      };
    };
  };

  extraPackages = with pkgs; [
    codespell # Fix common misspellings in source code
    biome # Toolchain of the web
    nodePackages.prettier # Prettier is an opinionated code formatter
    prettierd # Prettier, as a daemon, for improved formatting speed
  ];

  # autoCmd = [
  #   {
  #     event = "BufWritePre";
  #     pattern = [ "*" ];
  #     callback.__raw = ''
  #       function(args)
  #         require("conform").format({ bufnr = args.buf })
  #       end
  #     '';
  #   }
  # ];

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cf";
      action.__raw = # lua
        ''
          function()
            local bufnr = vim.api.nvim_get_current_buf()
            require("conform").format({ bufnr = bufnr })
          end
        '';
      options = {
        silent = true;
        desc = "Format";
      };
    }
  ];
}
