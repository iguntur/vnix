{ lib, pkgs, ... }:
{
  plugins = {
    # lsp.servers = { };

    # lint = {
    #   enable = true;
    #   lintersByFt = {
    #     sql = [ "sqlfluff" ];
    #     mysql = [ "sqlfluff" ];
    #     plsql = [ "sqlfluff" ];
    #   };
    # };

    conform-nvim.settings = {
      formatters_by_ft = {
        sql = [ "sqlfluff" ];
        mysql = [ "sqlfluff" ];
        plsql = [ "sqlfluff" ];
      };
    };
  };

  extraPackages = with pkgs; [
    sqlfluff
    sqruff
    # python313Packages.sqlfmt
  ];
}
