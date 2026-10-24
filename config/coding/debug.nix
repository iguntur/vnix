{ vnix, lib, pkgs, ... }:
let
  inherit (vnix.lua) fnRaw mkRequire;
  setup = a: b: fnRaw (mkRequire a b);
  # setup' = a: b: c: fnRaw (mkRequire a b c);
in
let
  inherit (vnix) icons;

  settings = {
    persistent-breakpoints = {
      load_breakpoints_event = [ "BufReadPost" ];
    };
  };
in
{
  plugins = {
    dap = {
      enable = true;
      adapters = { };
      configurations = { };
      signs = {
        dapBreakpoint.text = icons.dap.breakpoint;
        dapBreakpointCondition.text = icons.dap.breakpoint-condition;
        dapBreakpointRejected.text = icons.dap.breakpoint-rejected;
        dapLogPoint.text = icons.dap.log-point;
        dapStopped.text = icons.dap.stopped;
      };
      settings = { };
    };
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    (pkgs.vimUtils.buildVimPlugin {
      name = "persistent-breakpoints";
      src = pkgs.fetchFromGitHub {
        owner = "Weissle";
        repo = "persistent-breakpoints.nvim";
        rev = "4b199b1dcfd136cac8b0fa9c8dbbdeb81463f7a9";
        hash = "sha256-euwc9XD02g8W52Z8SzjSInLnatS3aGLY44Frvd+yDTc=";
      };
      dependencies = with pkgs.vimPlugins; [ nvim-dap ];
    })
  ];

  extraConfigLua = lib.strings.concatStringsSep "\n" [
    (vnix.lua.mkRequire' "persistent-breakpoints" "setup" settings.persistent-breakpoints)
    #lua
    ''
      -- setup dap event listeners {{{
      do
        require("dap").listeners.after.event_initialized["dapui_config"] = function()
          require("dapui").open({})
        end

        require("dap").listeners.before.event_terminated["dapui_config"] = function()
          require("dapui").close({})
        end

        require("dap").listeners.before.event_exited["dapui_config"] = function()
          require("dapui").close({})
        end
      end
      -- }}}
    ''
  ];

  keymaps = [
    # ------------------------------------------------------------------------------
    # DAP Core
    # ------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>dc";
      action = setup "dap" "continue";
      options = {
        silent = true;
        desc = "Run or Continue";
      };
    }
    # {
    #   mode = "n";
    #   key = "<leader>dC";
    #   action = setup' "dap" "run_to_cursor" {...};
    #   options = {
    #     silent = true;
    #     desc = "Run to cursor";
    #   };
    # }
    {
      mode = "n";
      key = "<leader>dg";
      action = setup "dap" "goto_";
      options = {
        silent = true;
        desc = "Go to line (No Execute)";
      };
    }
    {
      mode = "n";
      key = "<leader>di";
      action = setup "dap" "step_into";
      options = {
        silent = true;
        desc = "Step Into";
      };
    }
    {
      mode = "n";
      key = "<leader>dj";
      action = setup "dap" "down";
      options = {
        silent = true;
        desc = "Down";
      };
    }
    {
      mode = "n";
      key = "<leader>dk";
      action = setup "dap" "up";
      options = {
        silent = true;
        desc = "Up";
      };
    }
    {
      mode = "n";
      key = "<leader>dl";
      action = setup "dap" "run_last";
      options = {
        silent = true;
        desc = "Run Last";
      };
    }
    {
      mode = "n";
      key = "<leader>do";
      action = setup "dap" "step_out";
      options = {
        silent = true;
        desc = "Step Out";
      };
    }
    {
      mode = "n";
      key = "<leader>dO";
      action = setup "dap" "step_over";
      options = {
        silent = true;
        desc = "Step Over";
      };
    }
    {
      mode = "n";
      key = "<leader>dp";
      action = setup "dap" "pause";
      options = {
        silent = true;
        desc = "Pause";
      };
    }
    {
      mode = "n";
      key = "<leader>dr";
      action = setup "dap" "repl.toggle";
      options = {
        silent = true;
        desc = "Toggle REPL";
      };
    }
    {
      mode = "n";
      key = "<leader>ds";
      action = setup "dap" "session";
      options = {
        silent = true;
        desc = "Session";
      };
    }
    {
      mode = "n";
      key = "<leader>dt";
      action = setup "dap" "terminate";
      options = {
        silent = true;
        desc = "Terminate";
      };
    }
    {
      mode = "n";
      key = "<leader>dw";
      action = setup "dap.ui.widgets" "hover";
      options = {
        silent = true;
        desc = "Widgets";
      };
    }

    # ------------------------------------------------------------------------------
    # DAP UI
    # ------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>du";
      action = setup "dapui" "toggle";
      options = {
        silent = true;
        desc = "DAP UI";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>de";
      action = setup "dapui" "eval";
      options = {
        silent = true;
        desc = "DAP UI Eval";
      };
    }

    # ------------------------------------------------------------------------------
    # persistent-breakpoints
    # ------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>db";
      action = setup "persistent-breakpoints.api" "toggle_breakpoint";
      options = {
        silent = true;
        desc = "Toggle Breakpoint";
      };
    }
    {
      mode = "n";
      key = "<leader>dB";
      action = setup "persistent-breakpoints.api" "set_conditional_breakpoint";
      options = {
        silent = true;
        desc = "Breakpoint With Condition";
      };
    }
    {
      mode = "n";
      key = "<leader>dX";
      action = setup "persistent-breakpoints.api" "clear_all_breakpoints";
      options = {
        silent = true;
        desc = "Clear All Debug Breakpoints";
      };
    }
  ];
}
