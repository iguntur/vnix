{ ... }:
{
  plugins = {
    luasnip = {
      enable = true;
      settings = {
        history = true;
        delete_check_events = "TextChanged";
      };
    };

    friendly-snippets.enable = true;
  };
}
