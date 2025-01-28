{ pkgs, lib, ... }:
let
  inherit (lib.nixvim) toLuaObject;

  settings = {
    sibling-swap = {
      use_default_keymaps = false;
      keymaps = {
        "<space>[" = "swap_with_left";
        "<space>]" = "swap_with_right";
        "<space>;" = "swap_with_left_with_opp";
        "<space>." = "swap_with_right_with_opp";
      };
    };
  };
in
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "sibling-swap";
      src = pkgs.fetchFromGitHub {
        owner = "Wansmer";
        repo = "sibling-swap.nvim";
        rev = "4d3b8a9d80a8b3c8d76e74c2bdd13b6e7c4f8258";
        hash = "sha256-afeGKS1tgf/aqYlA7Pmq4eT+DEU65QIChvodvo7p50c=";
      };
    })
  ];

  extraConfigLua = ''
    require("sibling-swap").setup(${toLuaObject settings.sibling-swap})
  '';

  # keymaps = [ ];
}
