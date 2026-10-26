{ lib, pkgs, ... }:
let
  inherit (lib.nixvim) toLuaObject;
  rootMarkers = [
    "settings.gradle"
    "settings.gradle.kts"
    "pom.xml"
    "build.gradle"
    "mvnw"
    "gradlew"
    "build.gradle"
    "build.gradle.kts"
    ".project"
    ".classpath"
    ".git"
  ];
in
{
  plugins = {
    # jdtls = { enable = true; };
    java = {
      enable = true;
      settings = {
        root_markers = rootMarkers;
        # JDK dikelola Nix/devenv, jangan biarkan nvim-java download JDK sendiri.
        jdk.auto_install = false;
      };
    };

    spring-boot = {
      enable = true;
      settings.server = {
        root_dir.__raw = "vim.fs.root(0, ${toLuaObject rootMarkers})";
      };
    };

    lsp.servers = {
      # java_language_server.enable = false;
      jdtls = {
        enable = true;
        extraOptions.root_dir.__raw = # lua
          ''
            function(a, b)
              local markers = ${toLuaObject rootMarkers}
              if type(a) == "number" then
                local root = vim.fs.root(a, markers)
                if root then b(root) end
              else
                return vim.fs.root(a, markers)
              end
            end
          '';
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      # java = [ "palantir-java-format" ];
    };
  };

  # extraPackages = with pkgs; [
  # ];
}
