{ config, pkgs, ... }:
{
  plugins = {
    lint = {
      enable = true;
      lintersByFt = {
        sql = [ "sqlfuff" ];
        mysql = [ "sqlfuff" ];
        plsql = [ "sqlfuff" ];
      };
    };
  };

  # keymaps = [
  #   {
  #     mode = "n";
  #     key = "<leader>...";
  #     action = "<cmd>...<cr>";
  #     options = {
  #       silent = true;
  #       desc = "...";
  #     };
  #   }
  # ];
}
