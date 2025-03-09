{ lib, pkgs, vnix, ... }:
{
  extraPackages = with pkgs; [
    bat
    fd
    ripgrep # a.k.a rg
  ];

  plugins.fzf-lua = {
    enable = true;
    settings = {
      hls = {
        border = "None";
        normal = "None";
        backdrop = "None";
        title = "None";
        title_flags = "None";
        preview_title = "None";
        preview_normal = "None";
        preview_border = "None";
      };
      winopts = {
        # fullscreen = true;
        # preview = { default = "bat"; };
        width = 0.9;
        height = 0.9;
        backdrop = 100; # Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
      };
      previewers = {
        bat = {
          cmd = lib.getExe pkgs.bat;
          args = "--color=always --style=numbers,changes";
        };
      };
      # files = {
      #   fd_opts = lib.strings.concatStringsSep " " [
      #     "--color=never"
      #     "--hidden"
      #     "--type f"
      #     "--type l"
      #     "--exclude .git,node_modules"
      #   ];
      # };
    };

    keymaps = {
      # --------------------------------------------------------------------------------
      # Live Grep
      # --------------------------------------------------------------------------------
      "<leader>//" = {
        action = "live_grep";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Live Grep (cwd)";
        };
      };
      "<leader>/b" = {
        action = "lgrep_curbuf"; # live grep on current buffer
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Fuzzy Current Buffer";
        };
      };
      "<leader>/r" = {
        action = "live_grep";
        settings = {
          prompt = "❯ ";
          cwd.__raw = ''
            vim.fs.root(0, { ".git", "flake.nix", "Makefile", "go.work" })
          '';
        };
        options = {
          silent = true;
          desc = "Live Grep Project Root Directory (Upward)";
        };
      };
      "<leader>/." = {
        action = "live_grep";
        settings = {
          prompt = "❯ ";
          cwd.__raw = "vim.fn.expand('%:h:p')";
        };
        options = {
          silent = true;
          desc = "Live Grep Relative Working File";
        };
      };

      # --------------------------------------------------------------------------------
      # Auto Commands
      # --------------------------------------------------------------------------------
      "<leader>sa" = {
        action = "autocmds";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Autocommands";
        };
      };

      # --------------------------------------------------------------------------------
      # Buffers
      # --------------------------------------------------------------------------------
      "<leader>," = {
        action = "buffers"; # find buffers
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Pick Buffer";
        };
      };

      # --------------------------------------------------------------------------------
      # Commands
      # --------------------------------------------------------------------------------
      "<leader>s:" = {
        action = "commands";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Commands";
        };
      };
      "<leader>sC" = {
        action = "command_history";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Command History";
        };
      };

      # --------------------------------------------------------------------------------
      # Diagnostic
      # --------------------------------------------------------------------------------
      "<leader>sd" = {
        action = "diagnostics_document";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Diagnostic Document";
        };
      };
      "<leader>sD" = {
        action = "diagnostics_workspace";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Diagnostic Workspace";
        };
      };

      # --------------------------------------------------------------------------------
      # Files
      # --------------------------------------------------------------------------------
      "<leader>p" = {
        action = "files";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Find Files (cwd)";
        };
      };
      "<leader>ff" = {
        action = "files";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Find Files (cwd)";
        };
      };
      "<leader>fF" = {
        action = "files";
        settings = {
          # cwd_prompt = false;
          prompt = "❯ ";
          cwd.__raw = ''
            vim.fs.root(0, { ".git", "flake.nix", "go.work" })
          '';
        };
        options = {
          silent = true;
          desc = "Files Project Root Directory (Upward)";
        };
      };
      "<leader>f." = {
        action = "files";
        settings = {
          prompt = "❯ ";
          cwd.__raw = "vim.fn.expand('%:h:p')";
        };
        options = {
          silent = true;
          desc = "Files Relative Working File";
        };
      };

      # --------------------------------------------------------------------------------
      # Git Files
      # --------------------------------------------------------------------------------
      "<leader>gf" = {
        action = "git_files";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Git Files";
        };
      };
      "<leader>gs" = {
        action = "git_status";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Git Status";
        };
      };

      # --------------------------------------------------------------------------------
      # Help
      # --------------------------------------------------------------------------------
      "<leader>sh" = {
        action = "helptags";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Help";
        };
      };

      # --------------------------------------------------------------------------------
      # Jumps
      # --------------------------------------------------------------------------------
      "<leader>sj" = {
        action = "jumps";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Jumplist";
        };
      };

      # --------------------------------------------------------------------------------
      # Keymaps
      # --------------------------------------------------------------------------------
      "<leader>sk" = {
        action = "keymaps";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Keymaps";
        };
      };

      # --------------------------------------------------------------------------------
      # Location List
      # --------------------------------------------------------------------------------
      "<leader>sl" = {
        action = "loclist";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Location List";
        };
      };

      # --------------------------------------------------------------------------------
      # Marks
      # --------------------------------------------------------------------------------
      "<leader>sm" = {
        action = "marks";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Jump to Mark";
        };
      };

      # --------------------------------------------------------------------------------
      # Man Pages
      # --------------------------------------------------------------------------------
      "<leader>sM" = {
        action = "manpages";
        settings = {
          prompt = "Man Pages ❯ ";
        };
        options = {
          silent = true;
          desc = "Man Pages";
        };
      };

      # --------------------------------------------------------------------------------
      # Quickfix
      # --------------------------------------------------------------------------------
      "<leader>sq" = {
        action = "quickfix";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Quickfix List";
        };
      };
      "<leader>sQ" = {
        action = "quickfix_stack";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Quickfix Stack";
        };
      };

      # --------------------------------------------------------------------------------
      # Resume
      # --------------------------------------------------------------------------------
      "<leader>s<Up>" = {
        action = "resume";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Resume Last FZF Query";
        };
      };

      # --------------------------------------------------------------------------------
      # TODO: Todo
      # --------------------------------------------------------------------------------
      # "<leader>st" = {
      #   action = "";
      #   settings = {
      #     prompt = "❯ ";
      #   };
      #   options = {
      #     silent = true;
      #     desc = "";
      #   };
      # };
      # "<leader>sT" = {
      #   action = "";
      #   settings = {
      #     prompt = "❯ ";
      #   };
      #   options = {
      #     silent = true;
      #     desc = "";
      #   };
      # };

      # --------------------------------------------------------------------------------
      # Word
      # --------------------------------------------------------------------------------
      "<leader>sw" = {
        action = "grep_cword";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Grep Word (cword)";
        };
      };
      "<leader>sW" = {
        action = "grep_cWORD";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Grep Word (cWORD)";
        };
      };

      # --------------------------------------------------------------------------------
      # Register
      # --------------------------------------------------------------------------------
      "<leader>s\"" = {
        action = "registers";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Registers";
        };
      };

      # --------------------------------------------------------------------------------
      # LSP
      # --------------------------------------------------------------------------------
      "<leader>ca" = {
        action = "lsp_code_actions";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Code Action";
        };
      };
      "<leader>cs" = {
        action = "lsp_document_symbols";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Document Symbol";
        };
      };
      "<leader>cS" = {
        action = "lsp_live_workspace_symbols";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Workspace Symbol";
        };
      };

      "gd" = {
        action = "lsp_definitions";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Goto Definitions";
        };
      };
      "gD" = {
        action = "lsp_declarations";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Goto Declarations";
        };
      };
      "gr" = {
        action = "lsp_references";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Goto References";
        };
      };
      "gm" = {
        action = "lsp_implementations";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Goto Implementations";
        };
      };
      "gy" = {
        action = "lsp_typedefs";
        settings = {
          prompt = "❯ ";
        };
        options = {
          silent = true;
          desc = "Goto Type Definitions";
        };
      };

      # --------------------------------------------------------------------------------
      # path
      # --------------------------------------------------------------------------------
      "<C-x><C-f>" = {
        mode = [ "n" "v" "i" ];
        action = "complete_path";
        settings = {
          prompt = "❯ ";
          winopts = {
            fullscreen = false;
            width = 0.9;
            height = 0.5;
          };
        };
        options = {
          silent = true;
          desc = "Fuzzy complete path";
        };
      };

      # --------------------------------------------------------------------------------
      # ...
      # --------------------------------------------------------------------------------
      # "<leader>s" = {
      #   action = "";
      #   settings = {
      #     prompt = "❯ ";
      #   };
      #   options = {
      #     silent = true;
      #     desc = "";
      #   };
      # };
    };
  };

  # plugins.telescope = {
  #   enable = true;
  #   settings = { };
  # };
}
