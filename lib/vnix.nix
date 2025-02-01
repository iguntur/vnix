{ lib, pkgs, ... }:
let
  inherit (lib.nixvim) mkRaw toLuaObject;
in
{
  icons = import ./icons.nix;
  lua = import ./lua.nix { inherit lib; };

  lsp = rec {
    onAttach_keymaps = keymaps: # lua
      ''
        do
          local __keymaps = ${toLuaObject keymaps}
          for i, v in ipairs(__keymaps) do
            local default = { silent = true }
            local options = vim.tbl_deep_extend("force", default, v.options or {}, { buffer = bufnr })
            vim.keymap.set(v.mode or "n", v.key, v.action, options)
          end
        end
      '';
    buf.action = action: /* lua */ ''
      vim.lsp.buf.code_action(${toLuaObject {
        apply = true;
        context = {
          only = [ action ];
          diagnostics.__empty = null;
        };
      }})
    '';
    buf.action_fn = action: mkRaw "function() ${buf.action action} end";
    buf.execute = { open ? true, command, arguments }:
      if open then # lua
        ''
          require("trouble").open({
            mode = "lsp_command",
            params = ${toLuaObject { inherit command arguments; }},
          })
        ''
      else # lua
        ''
          local params = ${toLuaObject { inherit command arguments; }}
          vim.lsp.buf_request( 0, "workspace/executeCommand", params, nil)
        '';
    buf.execute_fn = inputs: mkRaw "function() ${buf.execute inputs} end";
  };
}
