{ config, lib, pkgs, ... }:
let
  treesitter-kulala-http-grammar = pkgs.tree-sitter.buildGrammar {
    language = "kulala_http";
    version = "5.3.1";
    src = pkgs.fetchFromGitHub {
      owner = "mistweaverco";
      repo = "kulala.nvim";
      rev = "902fc21e8a3fee7ccace37784879327baa6d1ece";
      hash = "sha256-whQpwZMEvD62lgCrnNryrEvfSwLJJ+IqVCywTq78Vf8=";
    };
    location = "lua/tree-sitter";
  };
in
{
  extraFiles = {
    "queries/lua/highlights.scm" = {
      enable = true;
      text = ''
        ;; extends

        ((identifier) @namespace.builtin
          (#eq? @namespace.builtin "vim"))
      '';
    };
  };

  plugins = {
    treesitter = {
      enable = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars ++ [
        treesitter-kulala-http-grammar
      ];
      luaConfig.post = # lua
        ''
          do
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            -- change the following as needed
            parser_config.kulala_http = {
              install_info = {
                url = "${treesitter-kulala-http-grammar}", -- local path or git repo
                files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
                -- optional entries:
                --  branch = "main", -- default branch in case of git repo if different from master
                -- generate_requires_npm = false, -- if stand-alone parser without npm dependencies
                -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
              },
              filetype = "kulala_http", -- if filetype does not match the parser name
            }
          end
        '';
      settings = {
        indent.enable = true;
        highlight.enable = true;
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<C-Space>";
            node_incremental = "<C-Space>";
            node_decremental = "<BS>"; # backspace
            scope_incremental = false; # set to `false` to disable one of the mappings
          };
        };

        # TODO: check
        # pairs = {
        #   # "theHamsta/nvim-treesitter-pairs"
        #   enable = true;
        #   enable_rename = true;
        #   enable_close = true;
        #   enable_close_on_slash = true;
        # };
      };
    };

    treesitter-textobjects = {
      enable = true;

      move = {
        enable = true;
        # gotoNext = { };
        # gotoPrevious = { };
        gotoNextStart = {
          "]a" = "@parameter.inner";
          "]c" = "@class.outer";
          "]f" = "@function.outer";
          "]i" = "@conditional.outer";
          "]l" = "@loop.outer";
        };
        gotoNextEnd = {
          "]A" = "@parameter.inner";
          "]C" = "@class.outer";
          "]F" = "@function.outer";
          "]I" = "@conditional.outer";
          "]L" = "@loop.outer";
        };
        gotoPreviousStart = {
          "[a" = "@parameter.inner";
          "[c" = "@class.outer";
          "[f" = "@function.outer";
          "[i" = "@conditional.outer";
          "[l" = "@loop.outer";
        };
        gotoPreviousEnd = {
          "[A" = "@parameter.inner";
          "[C" = "@class.outer";
          "[F" = "@function.outer";
          "[I" = "@conditional.outer";
          "[L" = "@loop.outer";
        };
      };

      select = {
        enable = true;
        lookahead = true; # Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          # You can use the capture groups defined in textobjects.scm
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
          "ii" = "@conditional.inner";
          "ai" = "@conditional.outer";
          "il" = "@loop.inner";
          "al" = "@loop.outer";
          "at" = "@comment.outer";
        };
      };
      swap = {
        enable = true;
        swapNext = {
          "<localleader>a" = {
            query = "@parameter.inner";
            desc = "Move parameter to the right";
          };
        };
        swapPrevious = {
          "<localleader>A" = {
            query = "@parameter.inner";
            desc = "Move parameter to the left";
          };
        };
      };
    };

    treesitter-context = {
      enable = true;
      settings = {
        # multiwindow = true;
        # separator = "-";
      };
      luaConfig.post = ''
        vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "None" })
        vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "None", fg = "#9f9f9f" })
        vim.api.nvim_set_hl(0, "TreesitterContextBottom", { bg = "#2f2f2f" })
        -- vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { bg = "#2f2f2f" })
        -- vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { bg = "None", fg = "#2f2f2f" })
      '';
    };

    # Use treesitter to autoclose and autorename html tag
    ts-autotag = {
      enable = true;
      # settings = { };
    };
  };

  # extraPlugins = [
  #   treesitter-kulala-http-grammar
  # ];

  keymaps = lib.optionals config.plugins.treesitter-context.enable [
    # --------------------------------------------------------------------------------
    # treesitter-context keymaps
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>ux";
      action = "<cmd>TSContextToggle<cr>";
      options.silent = true;
      options.desc = "Toggle treesitter context";
    }
    {
      mode = "n";
      key = "<leader>cx";
      action.__raw = ''
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end
      '';
      options = {
        desc = "Goto context code (upwards)";
        silent = true;
      };
    }
  ];
}
