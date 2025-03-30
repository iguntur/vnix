{ config, lib, pkgs, vnix, ... }:
{
  extraPackages = with pkgs; [
    delta
    git
  ];

  plugins = {
    fugitive = {
      enable = true;
    };

    diffview = {
      enable = true;
    };

    gitignore = {
      enable = true;
    };

    lazygit = {
      enable = true;
      settings = { };
    };

    # git-worktree = {
    #   enable = true;
    # };

    gitsigns = {
      enable = true;
      settings = {
        numhl = false; # Toggle with `:Gitsigns toggle_numhl`
        current_line_blame = true; # Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "right_align"; # 'eol' | 'overlay' | 'right_align'
          delay = 1000;
          ignore_whitespace = false;
          virt_text_priority = 100;
          use_focus = true;
        };
        current_line_blame_formatter = " <author>, 󰚭 <author_time:%R>  <summary>  ";
        signs = {
          add.text = "┃";
          change.text = "┃";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "┃";
          untracked.text = "┃";
        };
        signs_staged = {
          add.text = "┃";
          change.text = "┃";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "┃";
        };
        on_attach.__raw = # lua
          ''
            function(bufnr)
              local gs = require('gitsigns')
              local map = function(mode, lhs, rhs, opts)
                opts = vim.tbl_deep_extend("force", opts or {}, { silent = true, buffer = bufnr })
                vim.keymap.set(mode, lhs, rhs, opts)
              end

              map({ "n", "v" }, "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage Hunk" })
              map({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
              map("n", "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo Stage Hunk" })

              map("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "Preview Hunk Inline" })
              map("n", "<leader>ghP", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk" })
              map("n", "<leader>gr", "<cmd>Gitsigns refresh<cr>", { desc = "Gitsigns Refresh" })

              -- blame
              map("n", "<leader>gB", "<cmd>Gitsigns blame<cr>", { desc = "Blame" })
              map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })

              -- toggles
              map("n", "<leader>gts", "<cmd>Gitsigns toggle_signs<cr>", { desc = "Toggle signs" })
              map("n", "<leader>gtw", "<cmd>Gitsigns toggle_word_diff<cr>", { desc = "Toggle word diff" })
              map("n", "<leader>gtl", "<cmd>Gitsigns toggle_linehl<cr>", { desc = "Toggle linehl" })
              map("n", "<leader>gtn", "<cmd>Gitsigns toggle_numhl<cr>", { desc = "Toggle numhl" })
              map("n", "<leader>gtb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle current blame line" })

              for _, key in ipairs({ "[h", "<M-.>" }) do
                map("n", key, function() 
                  gs.nav_hunk("prev", nil, function()
                    vim.api.nvim_feedkeys("zz", "n", false)
                  end)
                end, { desc = "Prev Hunk" })
              end

              for _, key in ipairs({ "]h", "<M-,>" }) do
                map("n", key, function()
                  gs.nav_hunk("next", nil, function()
                    vim.api.nvim_feedkeys("zz", "n", false)
                  end)
                end, { desc = "Next Hunk" })
              end

              map("n", "[H", function()
                  gs.nav_hunk("first", nil, function()
                    vim.api.nvim_feedkeys("zz", "n", false)
                  end)
              end, { desc = "First Hunk" })

              map("n", "]H", function()
                  gs.nav_hunk("last", nil, function()
                    vim.api.nvim_feedkeys("zz", "n", false)
                  end)
              end, { desc = "Last Hunk" })

              -- vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { bg = "none", fg = "#45475a" })
              -- vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { bg = "none", fg = "#2079b1" })
              vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { bg = "none", fg = "#8d4797" })
            end
          '';
      };
    };

    which-key.luaConfig.post = vnix.lua.mkRequire' "which-key" "add" [
      { __unkeyed-1 = "<leader>gh"; group = "Hunk"; icon = " "; }
      { __unkeyed-1 = "<leader>ga"; group = "Add"; icon = " "; }
      { __unkeyed-1 = "<leader>gc"; group = "Commit"; icon = " "; }
      { __unkeyed-1 = "<leader>gp"; group = "Push"; icon = " "; }
      { __unkeyed-1 = "<leader>gt"; group = "Toggle"; icon = " "; }
    ];
  };

  keymaps = lib.optionals config.plugins.lazygit.enable [
    {
      mode = "n";
      key = "<C-g>";
      action = "<cmd>LazyGit<cr>";
      options.silent = true;
      options.desc = "Lazygit";
    }
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>LazyGit<cr>";
      options.silent = true;
      options.desc = "Lazygit";
    }
  ]
  ++ lib.optionals config.plugins.fugitive.enable [
    {
      mode = "n";
      key = "<leader>gaa";
      action = "<cmd>Git aa<cr>";
      options.silent = true;
      options.desc = "Git add all";
    }
    {
      mode = "n";
      key = "<leader>ga%";
      action = "<cmd>Git add %<cr>";
      options.silent = true;
      options.desc = "Git add current file";
    }
    {
      mode = "n";
      key = "<leader>gcc";
      action = "<cmd>Git commit<cr>";
      options.silent = true;
      options.desc = "Git commit";
    }
    {
      mode = "n";
      key = "<leader>gca";
      action = "<cmd>Git commit --amend<cr>";
      options.silent = true;
      options.desc = "Git commit --ammend";
    }
    {
      mode = "n";
      key = "<leader>gpp";
      action = "<cmd>Git push<cr>";
      options.silent = true;
      options.desc = "Git push";
    }
    {
      mode = "n";
      key = "<leader>gpP";
      action = "<cmd>Git push --force<cr>";
      options.silent = true;
      options.desc = "Git push --force";
    }
  ];
}
