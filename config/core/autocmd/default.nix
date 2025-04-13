{ lib, pkgs, ... }:
{
  imports = [
    ./cursor-center.nix
    ./highlight-cursor-line.nix
    ./highlight-text-yank.nix
    ./terminal.nix
  ];

  autoGroups = {
    vnix_nopaste.clear = true;
    vnix_conceal.clear = true;
    vnix_spell.clear = true;
  };

  autoCmd = [
    {
      event = [ "InsertLeave" ];
      group = "vnix_nopaste";
      pattern = [ "*" ];
      command = "set nopaste";
    }
    {
      event = [ "FileType" ];
      group = "vnix_conceal";
      pattern = [
        "json"
        "jsonc"
        "json5"
        "markdown"
      ];
      callback.__raw = ''
        function()
          -- vim.wo.conceallevel = 0
          vim.opt_local.conceallevel = 0
        end
      '';
    }
    {
      event = [ "FileType" ];
      group = "vnix_spell";
      pattern = [
        "markdown"
        "text"
        "gitcommit"
        "json5"
        "jsonc"
      ];
      callback.__raw = ''
        function()
          vim.opt_local.spell = true
        end
      '';
    }
  ];
}
