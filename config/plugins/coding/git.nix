{ config, pkgs, ... }:
{
  extraPackages = with pkgs; [
    delta
    git
  ];

  plugins = {
    diffview = {
      enable = true;
    };

    gitignore = {
      enable = true;
    };

    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
          untracked.text = "▎";
        };
        signs_staged = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
        };
        on_attach = # lua
          ''
            function(bufnr)
              local gs = package.loaded.gitsigns

              vim.keymap.set({ "n", "v" }, "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", { buffer = bufnr, silent = true, desc = "Stage Hunk" })
              vim.keymap.set({ "n", "v" }, "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { buffer = bufnr, silent = true, desc = "Reset Hunk" })
              vim.keymap.set("n", "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", { buffer = bufnr, silent = true, desc = "Undo Stage Hunk" })
              vim.keymap.set("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk_inline<cr>", { buffer = bufnr, silent = true, desc = "Preview Hunk Inline" })
              vim.keymap.set("n", "<leader>ghP", "<cmd>Gitsigns preview_hunk<cr>", { buffer = bufnr, silent = true, desc = "Preview Hunk" })
              vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns refresh<cr>", { buffer = bufnr, silent = true, desc = "Gitsigns Refresh" })
              vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>zz", { buffer = bufnr, silent = true, desc = "Prev Hunk" })
              vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>zz", { buffer = bufnr, silent = true, desc = "Next Hunk" })
              vim.keymap.set("n", "<M-.>", "<cmd>Gitsigns prev_hunk<cr>zz", { buffer = bufnr, silent = true, desc = "Prev Hunk" })
              vim.keymap.set("n", "<M-,>", "<cmd>Gitsigns next_hunk<cr>zz", { buffer = bufnr, silent = true, desc = "Next Hunk" })

              vim.keymap.set("n", "[H", function()
                  gs.nav_hunk("first")
                  vim.cmd.normal({ "zz", bang = true })
              end, { buffer = bufnr, silent = true, desc = "First Hunk" })

              vim.keymap.set("n", "]H", function()
                  gs.nav_hunk("last")
                  vim.cmd.normal({ "zz", bang = true })
              end, { buffer = bufnr, silent = true, desc = "Last Hunk" })
            end
          '';
      };
    };
  };
}
