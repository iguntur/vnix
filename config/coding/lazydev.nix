{ pkgs, lib, ... }:
{
  plugins.lazydev = {
    enable = true;
    lazyLoad.settings.ft = "lua";
    settings = {
      library = [
        {
          path = "\${3rd}/luv/library";
          words = [ "vim%.uv" ];
        }
        {
          path = "snacks.nvim";
          words = [ "Snacks" ];
        }
      ];
    };
  };
}
