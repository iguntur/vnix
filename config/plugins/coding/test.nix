{ config, pkgs, ... }:
{
  plugins = {
    neotest = {
      enable = true;
      settings = {
        status = {
          virtual_text = true;
        };
        icons = {
          running_animated = [
            "⠋"
            "⠙"
            "⠹"
            "⠸"
            "⠼"
            "⠴"
            "⠦"
            "⠧"
            "⠇"
            "⠏"
          ];
        };
      };

      # ------------------------------------------------------------------------------
      # Test adapters
      # ------------------------------------------------------------------------------
      # configured by per ft plugins
      # adapters = {
      #   golang = { }; # see: config/ft/go.nix
      # };
    };
  };

  keymaps = [
    # ------------------------------------------------------------------------------
    # Test run
    # ------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>tf";
      action.__raw = ''function() require("neotest").run.run(vim.fn.expand("%")) end'';
      options.silent = true;
      options.desc = "Run Current File (Test)";
    }
    {
      mode = "n";
      key = "<leader>tF";
      action.__raw = ''function() require("neotest").run.run(vim.uv.cwd()) end'';
      options.silent = true;
      options.desc = "Run All Test Files (Test)";
    }
    {
      mode = "n";
      key = "<leader>tr";
      action.__raw = ''function() require("neotest").run.run() end'';
      options.silent = true;
      options.desc = "Run Nearest (Test)";
    }
    {
      mode = "n";
      key = "<leader>tl";
      action.__raw = ''function() require("neotest").run.run_last() end'';
      options.silent = true;
      options.desc = "Run Last (Test)";
    }
    {
      mode = "n";
      key = "<leader>te";
      action.__raw = ''function() require("neotest").run.run({ suite = true }) end'';
      options.silent = true;
      options.desc = "Run Suite (Test)";
    }
    {
      mode = "n";
      key = "<leader>tS";
      action.__raw = ''function() require("neotest").run.stop() end'';
      options.silent = true;
      options.desc = "Stop (Test)";
    }

    # ------------------------------------------------------------------------------
    # Test watch
    # ------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>tw";
      action.__raw = ''function() require("neotest").watch.toggle(vim.fn.expand("%")) end'';
      options.silent = true;
      options.desc = "Toggle Watch (Test)";
    }

    # ------------------------------------------------------------------------------
    # Test summary/output
    # ------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>ts";
      action.__raw = ''function() require("neotest").summary.toggle() end'';
      options.silent = true;
      options.desc = "Toggle Summary (Test)";
    }
    {
      mode = "n";
      key = "<leader>to";
      action.__raw = ''function() require("neotest").output.open({ enter = true, auto_close = true }) end'';
      options.silent = true;
      options.desc = "Show Output (Test)";
    }
    {
      mode = "n";
      key = "<leader>tO";
      action.__raw = ''function() require("neotest").output_panel.toggle() end'';
      options.silent = true;
      options.desc = "Toggle Output Panel (Test)";
    }

    # ------------------------------------------------------------------------------
    # Test debug
    # ------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>td";
      action.__raw = ''function() require("neotest").run.run({ strategy = "dap", suite = false }) end'';
      options.silent = true;
      options.desc = "Run Debug Nearest (Test)";
    }
    {
      mode = "n";
      key = "<leader>tD";
      action.__raw = ''function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end'';
      options.silent = true;
      options.desc = "Run Debug File (Test)";
    }
  ];
}
