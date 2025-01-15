{ pkgs, ... }:
{
  plugins = {
    treesitter = {
      enable = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
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
          "]l" = "@loop.outer";
        };
        gotoNextEnd = {
          "]A" = "@parameter.inner";
          "]C" = "@class.outer";
          "]F" = "@function.outer";
          "]L" = "@loop.outer";
        };
        gotoPreviousStart = {
          "[a" = "@parameter.inner";
          "[c" = "@class.outer";
          "[f" = "@function.outer";
          "[l" = "@loop.outer";
        };
        gotoPreviousEnd = {
          "[A" = "@parameter.inner";
          "[C" = "@class.outer";
          "[F" = "@function.outer";
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
          "<leader>a" = "@parameter.inner";
        };
        swapPrevious = {
          "<leader>A" = "@parameter.inner";
        };
      };
    };

    treesitter-context = {
      enable = true;
    };

    #   Use treesitter to autoclose and autorename html tag
    ts-autotag = {
      enable = true;
      # settings = { };
    };
  };

  keymaps = [
    # --------------------------------------------------------------------------------
    # treesitter-context keymaps
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>cx";
      action.__raw = ''
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end
      '';
      options = {
        desc = "Jumping to context code (upwards)";
        silent = true;
      };
    }
  ];
}
