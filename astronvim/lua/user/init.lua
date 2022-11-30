local config = {
  options = {
    opt = {
      relativenumber = false, -- Reset to vim default
      foldmethod = "marker", -- Reset to vim default
      pastetoggle = "<F3>",
    },
  },

  mappings = {
    -- Normal mode mappings
    n = {
      ["/<BS>"] = { "<cmd>nohlsearch<cr>", desc = "Clear search highlight" },
      -- Move between splits with M-arrows
      ["<M-Left>"] = { "<C-w>h", desc = "Move to window left" },
      ["<M-Down>"] = { "<C-w>j", desc = "Move to window below" },
      ["<M-Up>"] = { "<C-w>k", desc = "Move to widnow above" },
      ["<M-Right>"] = { "<C-w>l", desc = "Move to window right" },
      -- For buffer navigation
      ["<M-]>"] = { "<cmd>bn<CR>", desc = "Show next buffer" },
      ["<M-[>"] = { "<cmd>bp<CR>", desc = "Show previous buffer" },
      ["<M-w>"] = { "<cmd>bd<CR>", desc = "Delete buffer" },
      -- Schlepp-like
      ["<S-M-Down>"] = { "<cmd>m +<CR>", desc = "Move line 1 down" },
      ["<S-M-Up>"] = { "<cmd>m -2<CR>", desc = "Move line 1 up" },
    },
    -- Visual mode mappings
    v = {
      [">"] = { ">gv", desc = "Indent selected lines" },
      ["<"] = { "<gv", desc = "Dedent selected lines" },
      -- Schlepp-like
      ["<S-M-Left>"] = { "<Plug>SchleppLeft", desc = "Move visual block left" },
      ["<S-M-Down>"] = { "<Plug>SchleppDown", desc = "Move visual block down" },
      ["<S-M-Up>"] = { "<Plug>SchleppUp", desc = "Move visual block up" },
      ["<S-M-Right>"] = { "<Plug>SchleppRight", desc = "Move visual block right" },
      ["D"] = { "<Plug>SchleppDup", desc = "Duplicate visual block" },
    },
    -- Insert mode mappings
    i = {
      -- Some emacs-like bindings in insert mode
      ["<M-Backspace>"] = { "<C-w>", desc = "Delete word" },
      ["<M-Left>"] = { "<C-o>b", desc = "Move left 1 word" },
      ["<M-Right>"] = { "<C-o>w", desc = "Move right 1 word" },
    }
  },

  plugins = {
    init = {
      ["zirrostig/vim-schlepp"] = {},
      ["tpope/vim-surround"] = {},
      ["tpope/vim-repeat"] = {},
      ["tpope/vim-unimpaired"] = {},
      ["Konstruktionist/vim-fish"] = {},
    }
  },
}

return config
