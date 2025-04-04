{ config, lib, pkgs, ... }:
{
  # global options
  globals = {
    mapleader = " "; # use <space> as leader key
    maplocalleader = "\\";
  };

  # options
  opts = {
    # shortmess:append("I") -- Disable Neovim welcome page
    # shortmess:append("Ws") -- Disable Neovim welcome page
    # wildcharm      = 4
    background = "dark";
    backspace = [
      "indent"
      "eol"
      "start"
    ];
    backup = false; # create backup file
    # cino = ":0"; # (C Lang) No indent for case:/default:
    clipboard = "";
    # colorcolumn = "80,110,120";
    completeopt = [
      "menu"
      "menuone"
      "noselect"
    ];
    confirm = true; # confirm to save changes before exiting modified buffer
    cursorline = true; # enable highlighting of the current line
    cursorcolumn = true; # enable highlighting of the current column
    encoding = "utf-8";
    fileencoding = "utf-8";
    hlsearch = true; # highlight search result
    ignorecase = true; # ignore case
    inccommand = "nosplit"; # preview incremental substitute
    incsearch = true; # move cursor to search as you type
    jumpoptions = "view";
    laststatus = 3; # global statusline
    linebreak = true; # wrap lines at convenient points
    list = true; # show some invisible characters (tabs...
    listchars = {
      tab = "│ "; # "│·"; # "▸ ";
      # trail = "∙"; # "·";
      # nbsp = "∙";
      # eol = "↴"; eol = '↲'; };
    };
    mouse = "a"; # enable mouse mode
    number = true; # show line number
    numberwidth = 6;
    pumblend = 10; # popup blend
    pumheight = 10; # max popup entries
    relativenumber = true; # show relative line number
    ruler = false; # disable ruler
    scrolloff = 10; # lines of context
    sessionoptions = [
      "buffers"
      "curdir"
      "tabpages"
      "winsize"
      "help"
      "globals"
      "skiprtp"
      "folds"
    ];
    showmatch = true;
    # showmode = false; # dont show mode since we have a statusline
    sidescrolloff = 10; # columns of context
    smartcase = true; # don't ignore case with capitals
    smoothscroll = true; # optional but improves reproducibility
    splitbelow = true; # make all horizontal split to go below window
    # splitkeep = "screen";
    splitright = true; # make all vertical split to go to the right
    swapfile = false;
    termguicolors = true; # true color support
    textwidth = 110;
    title = true;
    undodir.__raw = ''vim.fn.expand("$XDG_CACHE_HOME/vnix-undodir")''; # undofile path location
    undofile = true; # enable persistent undo
    undolevels = 100000;
    virtualedit = "block"; # allow cursor to move where there is no text in visual block mode
    wildmode = "longest:full,full"; # command-line completion mode
    wrap = false; # disable line wrap

    # status column
    signcolumn = lib.mkDefault "auto:3";

    # indent
    autoindent = true;
    cindent = true;
    expandtab = false; # use tabs instead
    shiftround = true; # round indent
    shiftwidth = 2; # size of an indent
    smartindent = true; # add indent automatically
    smarttab = true;
    softtabstop = 2;
    tabstop = 2; # number of spaces tabs count for

    # wildignore:append({
    #     "*/node_modules/*",
    #     "*/vendor/*",
    # })
  };
}
