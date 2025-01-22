{ pkgs, ... }:
{
  keymaps = [
    # --------------------------------------------------------------------------------
    # Tab
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader><tab><tab>";
      action = ":tabnew<cr>";
      options.desc = "Create a new tab";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader><tab>d";
      action = ":tabclose<cr>";
      options.desc = "Close current tab";
      options.silent = true;
    }
    # {
    #   mode = "n";
    #   key = "<C-M-[>"; # Control-Alt-[
    #   action = ":tabfirst<cr>";
    #   options.desc = "Select the first tab";
    #   options.silent = true;
    # }
    # {
    #   mode = "n";
    #   key = "<C-M-]>"; # Control-Alt-]
    #   action = ":tablast<cr>";
    #   options.desc = "Select the last tab";
    #   options.silent = true;
    # }

    # --------------------------------------------------------------------------------
    # Tab: Navigate
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader><tab>f";
      action = ":tabfirst<cr>";
      options.desc = "Jump to the first tab";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader><tab>l";
      action = ":tablast<cr>";
      options.desc = "Jump to the last tab";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<M-]>"; # Alt-]
      action = ":tabnext<cr>";
      options.desc = "Select the next tab";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<M-[>"; # Alt-[
      action = ":tabprevious<cr>";
      options.desc = "Select the previous tab";
      options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # Tab: Movement
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<M-{>"; # Alt-{
      action = ":-tabmove<cr>";
      options.desc = "Move current tab to the left";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<M-}>"; # Alt-}
      action = ":+tabmove<cr>";
      options.desc = "Move current tab to the right";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader><tab>0";
      action = ":0tabmove<cr>";
      options.desc = "Move the tab page to the first";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader><tab>$";
      action = ":$tabmove<cr>";
      options.desc = "Move the tab page to the last";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader><tab>#";
      action = ":tabmove #<cr>";
      options.desc = "Move the tab page after the last accessed tab page";
      options.silent = true;
    }
  ];
}
