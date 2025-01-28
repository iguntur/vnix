{ luaRaw, ... }:
{
  plugins = {
    todo-comments = {
      enable = true;
      # settings = { };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "]t";
      action = luaRaw.keymapRequire "todo-comments" "jump_next";
      options = {
        silent = true;
        desc = "Next todo comment";
      };
    }
    {
      mode = "n";
      key = "[t";
      action = luaRaw.keymapRequire "todo-comments" "jump_prev";
      options = {
        silent = true;
        desc = "Previous todo comment";
      };
    }
    {
      mode = "n";
      key = "<leader>st";
      action = "<cmd>TodoFzfLua<cr>";
      options = {
        silent = true;
        desc = "Grep Todo (fzf)";
      };
    }
  ];
}
