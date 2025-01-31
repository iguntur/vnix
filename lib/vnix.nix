{ lib, pkgs, ... }:
{
  icons = import ./icons.nix;
  lua = import ./lua.nix { inherit lib; };

  lsp = {
    buf.action = act: /* lua */ ''
      vim.lsp.buf.code_action(${lib.nixvim.toLuaObject {
        apply = true;
        context = {
          only = act;
          diagnostics.__empty = null;
        };
      }})
    '';
  };
}
