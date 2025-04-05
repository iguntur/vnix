{ config, lib, pkgs, vnix, ... }:
let
  endpoint = "http://127.0.0.1:11434";
  model = "qwen2.5-coder:7b";
  # model = "qwen2.5-coder:1.5b";
in
{
  plugins.avante = {
    enable = true;
    package = pkgs.vimPlugins.avante-nvim.overrideAttrs (prevAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "yetone";
        repo = "avante.nvim";
        rev = "main";
        hash = "sha256-kd48FfxzDaVVhYQdW1LNjBoePa2b0BS/aqASj6eBmOQ=";
      };
      nvimSkipModules = prevAttrs.nvimSkipModules ++ [
        # Requires setup with corresponding provider
        "avante.providers.ollama"
        "avante.providers.vertex_claude"
      ];
    });
    settings = {
      auto_suggestions_provider = "ollama";
      provider = "ollama"; # "claude" | "openai" | "azure" | "gemini" | "vertex" | "cohere" | "copilot" | "bedrock" | "ollama"
      ollama = {
        inherit endpoint model;
        timeout = 30000; # Timeout in milliseconds
        disable_tools = true;
        options = {
          temperature = 0;
          num_ctx = 20480;
        };
      };
      rag_service = {
        enabled = true; # Enables the RAG service
        host_mount.__raw = ''vim.fn.expand("$HOME/dev")''; # Host mount path for the rag service
        provider = "ollama"; # The provider to use for RAG service (e.g. openai or ollama)
        llm_model = model; # The LLM model to use for RAG service
        embed_model = "nomic-embed-text"; # The embedding model to use for RAG service
        inherit endpoint;
      };
    };
  };

  plugins.which-key.settings.spec = lib.optionals config.plugins.avante.enable [
    {
      __unkeyed-1 = "<leader>a";
      group = "AI";
      icon = "󰨈 ";
    }
  ];

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
