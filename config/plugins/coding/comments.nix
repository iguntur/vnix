{ ... }:
{
  plugins = {
    ts-comments = {
      enable = true;
      settings = { };
    };

    # ts-context-commentstring = {
    #   enable = true;
    #   extraOptions = {
    #     enable_autocmd = false;
    #   };
    # };

    # mini.modules = {
    #   comment = {
    #     options = {
    #       custom_commentstring = # lua
    #         ''
    #           function()
    #             return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
    #           end
    #         '';
    #     };
    #     # mappings = {};
    #   };
    # };
  };
}
