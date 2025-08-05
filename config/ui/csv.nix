{ lib, pkgs, vnix, ... }:
{
  plugins = {
    csvview = {
      enable = true;
      settings = {
        parser = {
          async_chunksize = 30;
        };
        view = {
          display_mode = "border";
          spacing = 4;
          header_lnum = 1; # Auto-detect header (default)
        };
      };
    };
  };
}

