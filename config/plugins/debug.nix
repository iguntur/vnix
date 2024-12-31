{
  vnix,
  lib,
  pkgs,
  luaRaw,
  ...
}:
let
  inherit (vnix) icons;
  inherit (lib.nixvim) toLuaObject;

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
      extensions = {
        dap-ui.enable = true;
        dap-virtual-text.enable = true;
        dap-go.enable = true;
        # dap-python.enable = true;
      };
      signs = {
        dapBreakpoint.text = icons.dap.breakpoint;
        dapBreakpointCondition.text = icons.dap.breakpoint-condition;
        dapBreakpointRejected.text = icons.dap.breakpoint-rejected;
        dapLogPoint.text = icons.dap.log-point;
        dapStopped.text = icons.dap.stopped;
      };
      extraOptions = { };
    };
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

  extraConfigLua = ''
    require("persistent-breakpoints").setup(${toLuaObject settings.persistent-breakpoints})

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
  '';

  keymaps = [
    # ------------------------------------------------------------------------------
    # DAP Core
    # ------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>dc";
      action = luaRaw.keymapRequire "dap" "continue";
      options = {
        silent = true;
        desc = "Run or Continue";
      };
    }
    # {
    #   mode = "n";
    #   key = "<leader>dC";
    #   action = luaRaw.keymapRequire' "dap" "run_to_cursor" {...};
    #   options = {
    #     silent = true;
    #     desc = "Run to cursor";
    #   };
    # }
    {
      mode = "n";
      key = "<leader>dg";
      action = luaRaw.keymapRequire "dap" "goto_";
      options = {
        silent = true;
        desc = "Go to line (No Execute)";
      };
    }
    {
      mode = "n";
      key = "<leader>di";
      action = luaRaw.keymapRequire "dap" "step_into";
      options = {
        silent = true;
        desc = "Step Into";
      };
    }
    {
      mode = "n";
      key = "<leader>dj";
      action = luaRaw.keymapRequire "dap" "down";
      options = {
        silent = true;
        desc = "Down";
      };
    }
    {
      mode = "n";
      key = "<leader>dk";
      action = luaRaw.keymapRequire "dap" "up";
      options = {
        silent = true;
        desc = "Up";
      };
    }
    {
      mode = "n";
      key = "<leader>dl";
      action = luaRaw.keymapRequire "dap" "run_last";
      options = {
        silent = true;
        desc = "Run Last";
      };
    }
    {
      mode = "n";
      key = "<leader>do";
      action = luaRaw.keymapRequire "dap" "step_out";
      options = {
        silent = true;
        desc = "Step Out";
      };
    }
    {
      mode = "n";
      key = "<leader>dO";
      action = luaRaw.keymapRequire "dap" "step_over";
      options = {
        silent = true;
        desc = "Step Over";
      };
    }
    {
      mode = "n";
      key = "<leader>dp";
      action = luaRaw.keymapRequire "dap" "pause";
      options = {
        silent = true;
        desc = "Pause";
      };
    }
    {
      mode = "n";
      key = "<leader>dr";
      action = luaRaw.keymapRequire "dap" "repl.toggle";
      options = {
        silent = true;
        desc = "Toggle REPL";
      };
    }
    {
      mode = "n";
      key = "<leader>ds";
      action = luaRaw.keymapRequire "dap" "session";
      options = {
        silent = true;
        desc = "Session";
      };
    }
    {
      mode = "n";
      key = "<leader>dt";
      action = luaRaw.keymapRequire "dap" "terminate";
      options = {
        silent = true;
        desc = "Terminate";
      };
    }
    {
      mode = "n";
      key = "<leader>dw";
      action = luaRaw.keymapRequire "dap.ui.widgets" "hover";
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
      action = luaRaw.keymapRequire "dapui" "toggle";
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
      action = luaRaw.keymapRequire "dapui" "eval";
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
      action = luaRaw.keymapRequire "persistent-breakpoints.api" "toggle_breakpoint";
      options = {
        silent = true;
        desc = "Toggle Breakpoint";
      };
    }
    {
      mode = "n";
      key = "<leader>dB";
      action = luaRaw.keymapRequire "persistent-breakpoints.api" "set_conditional_breakpoint";
      options = {
        silent = true;
        desc = "Breakpoint With Condition";
      };
    }
    {
      mode = "n";
      key = "<leader>dX";
      action = luaRaw.keymapRequire "persistent-breakpoints.api" "clear_all_breakpoints";
      options = {
        silent = true;
        desc = "Clear All Debug Breakpoints";
      };
    }
  ];
}
