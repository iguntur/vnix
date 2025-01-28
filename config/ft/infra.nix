{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      ansiblels.enable = true;
      dockerls.enable = true;
      terraformls.enable = true;
      nginx_language_server.enable = true;
      helm_ls = {
        enable = true;
        # filetypes = [ "helm" ];
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      terraform = [ "terraform" ];
      # terraform = [ "tofu_fmt" ];
    };
  };

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      # Small neovim plugin to make working with Ansible playbooks or roles more convenient
      name = "nvim-ansible";
      src = pkgs.fetchFromGitHub {
        owner = "mfussenegger";
        repo = "nvim-ansible";
        rev = "44dabdaa8a9193b7f564a8408ed6d7107705030a";
        hash = "sha256-uigPQ6VAXjs52XkYHJMKHxKKwpqnsJmhocsTpMq40ac=";
      };
    })
  ];

  # extraPackages = with pkgs; [
  # ];
}
