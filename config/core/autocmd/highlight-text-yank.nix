{ lib, pkgs, ... }:
{
  autoGroups = {
    vnix_highlight_yank.clear = true;
  };

  autoCmd = [
    {
      # Highlight on yank
      event = "TextYankPost";
      group = "vnix_highlight_yank";
      callback.__raw = ''
        function()
          (vim.hl or vim.highlight).on_yank()
        end
      '';
    }
  ];
}

