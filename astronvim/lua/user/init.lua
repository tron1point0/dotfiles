local config = {
  options = {
    opt = {
      relativenumber = false, -- Reset to vim default
      foldmethod = "marker", -- Reset to vim default
      colorcolumn = "+0,+40", -- Highlight textwidth col and further out
      textwidth = 80, -- Default unless set by filetype
      winminwidth = 10, -- Don't allow windows to become too small
      list = true, -- Show nonprintable characters
      listchars = { -- Use these characters for that
        conceal = '⁞',
        extends = '❯',
        nbsp = '…',
        precedes = '❮',
        trail = '•',
      },
    },
  },

  mappings = {
    -- {{{ Normal mode mappings
    n = {
      ["/<BS>"] = { "<cmd>nohlsearch<cr>", silent = true, desc = "Clear search highlight" },
      -- Move between splits with M-arrows
      ["<M-Left>"] = { "<C-w>h", desc = "Move to window left" },
      ["<M-Down>"] = { "<C-w>j", desc = "Move to window below" },
      ["<M-Up>"] = { "<C-w>k", desc = "Move to widnow above" },
      ["<M-Right>"] = { "<C-w>l", desc = "Move to window right" },
      -- For buffer navigation
      ["<M-]>"] = { "<cmd>BufferLineCycleNext<CR>", desc = "Show next buffer" },
      ["<M-[>"] = { "<cmd>BufferLineCyclePrev<CR>", desc = "Show previous buffer" },
      ["<M-w>"] = { function() require("bufdelete").bufdelete(0, false) end, desc = "Delete buffer" },
      -- Same, but for OSX
      ["‘"] = { "<cmd>BufferLineCycleNext<CR>", desc = "Show next buffer" },
      ["“"] = { "<cmd>BufferLineCyclePrev<CR>", desc = "Show previous buffer" },
      ["∑"] = { function() require("bufdelete").bufdelete(0, false) end, desc = "Delete buffer" },
      -- Same, but for OSX in a gui
      ["<D-]>"] = { "<cmd>BufferLineCycleNext<CR>", desc = "Show next buffer" },
      ["<D-[>"] = { "<cmd>BufferLineCyclePrev<CR>", desc = "Show previous buffer" },
      ["<D-w>"] = { function() require("bufdelete").bufdelete(0, false) end, desc = "Delete buffer" },
      -- Schlepp-like
      ["<S-M-Down>"] = { "<cmd>m +<CR>", desc = "Move line 1 down" },
      ["<S-M-Up>"] = { "<cmd>m -2<CR>", desc = "Move line 1 up" },
      -- Unimpaired for changes
      ["]c"] = { function() require("gitsigns").next_hunk() end, desc = "Next git hunk" },
      ["[c"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous git hunk" },
    },
    -- }}}
    -- {{{ Visual mode mappings
    v = {
      -- Schlepp
      ["<S-M-Left>"] = { "<Plug>SchleppLeft", desc = "Move visual block left" },
      ["<S-M-Down>"] = { "<Plug>SchleppDown", desc = "Move visual block down" },
      ["<S-M-Up>"] = { "<Plug>SchleppUp", desc = "Move visual block up" },
      ["<S-M-Right>"] = { "<Plug>SchleppRight", desc = "Move visual block right" },
      ["D"] = { "<Plug>SchleppDup", desc = "Duplicate visual block" },
    },
    -- }}}
    -- {{{ Insert mode mappings
    i = {
      -- Some emacs-like bindings in insert mode
      ["<M-Backspace>"] = { "<C-w>", desc = "Delete word" },
      ["<M-Left>"] = { "<C-o>b", desc = "Move left 1 word" },
      ["<M-Right>"] = { "<C-o>w", desc = "Move right 1 word" },
    }
    -- }}}
  },

  plugins = {
    -- {{{ Additional basic plugins to load
    init = {
      ["zirrostig/vim-schlepp"] = {},
      ["tpope/vim-surround"] = {},
      ["tpope/vim-repeat"] = {},
      ["tpope/vim-unimpaired"] = {},
      ["Konstruktionist/vim-fish"] = {},
    }
    -- }}}
  },
}

-- {{{ Bind the typos

vim.api.nvim_create_user_command('Q', function()
  vim.cmd.q()
end, {})

vim.api.nvim_create_user_command('W', function()
  vim.cmd.w()
end, {})

vim.api.nvim_create_user_command('WQ', function()
  vim.cmd.q()
  vim.cmd.w()
end, {})

-- }}}

-- {{{ Configure gui clients

if vim.fn.has('gui') then
  -- Fonts
  if vim.fn.has('mac') then -- Any GUI on OSX
    vim.opt.guifont = 'FiraCode Nerd Font,Fira Code,Menlo:h14'
  elseif vim.fn.has('linux') then -- GNvim on Linux
    vim.opt.guifont = 'FiraCode Nerd Font 12,Ubuntu Mono 12'
  elseif vim.fn.has('unix') then -- Neovide on linux
    vim.opt.guifont = 'FiraCode Nerd Font:h12'
  end
end

-- }}}

return config
