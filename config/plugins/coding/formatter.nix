{ pkgs, lib, ... }:
{
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
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          blade = [
            "blade-formatter"
            "rustywind"
          ];
          # cpp = [ "clang_format" ];
          go = [
            "gofumpt"
            "goimports-reviser"
            "golines"
          ];
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            timeout_ms = 2000;
            stop_after_first = true;
          };
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          php = [ "pint" ];
          python = [
            "isort"
            "black"
          ];
          sh = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          svelte = [
            "prettierd"
            "rustywind"
          ];
          templ = [
            "templ"
            "rustywind"
          ];
        };
        formatters = {
          injected = {
            options = {
              ignore_errors = true;
            };
          };
          squeeze_blanks.command = lib.getExe' pkgs.coreutils "cat";
          golines = {
            prepend_args = [ "--max-len=120" ];
          };
        };
        format_on_save = {
          timeout_ms = 500;
          lsp_format = "fallback";
        };
        format_after_save = {
          lsp_format = "fallback";
        };
      };
    };
  };

  extraPackages = with pkgs; [
    blade-formatter # Laravel Blade template formatter
    codespell # Fix common misspellings in source code
    nixfmt-rfc-style # (nixfmt) Official formatter for Nix code
    rustywind # A tool for formatting Tailwind CSS classes.
    stylua # Opinionated Lua code formatter
    templ # Language for writing HTML user interfaces in Go

    # shell
    shellcheck # Shell script analysis tool
    shellharden # Corrective bash syntax highlighter
    shfmt # Shell parser and formatter

    # Golang
    gofumpt # Stricter gofmt
    goimports-reviser # Right imports sorting & code formatting tool (goimports alternative)
    golines # Golang formatter that fixes long lines

    # Python
    black # Uncompromising Python code formatter
    isort # Python utility / library to sort Python imports

    # Typescript, Javascript, ...
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
