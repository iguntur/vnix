{ config, lib, pkgs, ... }:
{
  plugins.kulala = {
    enable = true;
    lazyLoad.settings = {
      ft = [ "http" "rest" ];
    };
    settings = {
      global_keymaps = false;
      # additional cURL options. see: https://curl.se/docs/manpage.html
      additional_curl_options = [
        "-L" # --location => (HTTP) If the server reports that the requested page has moved to a different location
      ];
    };
  };

  autoGroups.vnix_kulala.clear = true;
  autoCmd = [
    {
      event = "FileType";
      group = "vnix_kulala";
      pattern = [ "http" "rest" ];
      callback.__raw = ''
        function()
          local k = require("kulala")

          local map = function(mode, lhs, rhs, opts)
            local bufnr = vim.api.nvim_get_current_buf()
            opts = opts or {}
            opts = vim.tbl_deep_extend("force", { silent = true }, opts, { buffer = bufnr })
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          map({"n", "v"}, "<CR>", function() k.run() end, { desc = "Send request <cr>" })
          map({"n", "v"}, "<localleader>hs", function() k.run() end, { desc = "Send request" })
          map({"n", "v" }, "<localleader>ha", function() k.run_all() end, { desc = "Send all requests" })
          map("n", "<localleader>hr", function() k.replay() end, { desc = "Replay the last request" })

          map("n", ")", function() k.jump_next() end, { desc = "Jump to next request" })
          map("n", "(", function() k.jump_prev() end, { desc = "Jump to previous request" })

          map("n", "<localleader>ho", function() k.open() end, { desc = "Open kulala" })
          map("n", "<localleader>hc", function() k.copy() end, { desc = "Copy as cURL" })
          map("n", "<localleader>hC", function() k.from_curl() end, { desc = "Paste from curl" })
          map("n", "<localleader>he", function() k.set_selected_env() end, { desc = "Select environment" })

          map("n", "<localleader>hx", function() k.scripts_clear_global() end, { desc = "Clear globals" })
          map("n", "<localleader>hX", function() k.clear_cached_files() end, { desc = "Clear cached files" })

          map("n", "<localleader>hi", function() k.inspect() end, { desc = "Inspect current request" })
          map("n", "<localleader>hf", function() k.search() end, { desc = "Find request" })

          -- map("n", "<localleader>hg", function() k.download_graphql_schema() end, { desc = "Download GraphQL schema" })
          --
          -- map("n", "<localleader>hb", function() k.scratchpad() end, { desc = "Open scratchpad" })
          -- map("n", "<localleader>ht", function() k.toggle_view() end, { desc = "Toggle headers/body" })
          -- map("n", "<localleader>hS", function() k.show_stats() end, { desc = "Show stats" })
          -- map("n", "<localleader>hq", function() k.close() end, { desc = "Close window" })
        end
      '';
    }
  ];

  plugins.rest = {
    enable = true;
    settings = { };
  };
}
