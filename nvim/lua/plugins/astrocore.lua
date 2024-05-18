-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        relativenumber = false, -- Reset to vim default
        foldmethod = "marker",  -- Reset to vim default
        colorcolumn = "+0,+40", -- Highlight textwidth col and further out
        textwidth = 80,         -- Default unless set by filetype
        tabstop = 4,            -- Default unless set by filetype
        shiftwidth = 0,         -- Use tabstop vaule unless set by filetype
        spell = true,           -- Turn on spell checking
        winminwidth = 10,       -- Don't allow windows to become too small
        list = true,            -- Show nonprintable characters
        listchars = {
          -- Use these characters for that
          conceal = '⁞',
          extends = '❯',
          nbsp = '…',
          precedes = '❮',
          tab = '——⇥',
          trail = '•',
        },
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- {{{ Normal mode mappings
      n = {
        ["/<BS>"] = { "<cmd>nohlsearch<cr>", silent = true, desc = "Clear search highlight" },
        -- Move between splits with M-arrows
        ["<M-Left>"] = { "<C-w>h", desc = "Move to window left" },
        ["<M-Down>"] = { "<C-w>j", desc = "Move to window below" },
        ["<M-Up>"] = { "<C-w>k", desc = "Move to window above" },
        ["<M-Right>"] = { "<C-w>l", desc = "Move to window right" },
        -- For buffer navigation
        ["<M-]>"] = { "<cmd>bnext<cr>", desc = "Show next buffer" },
        ["<M-[>"] = { "<cmd>bprev<cr>", desc = "Show previous buffer" },
        ["<M-w>"] = { "<cmd>Bdelete<cr>", desc = "Delete buffer" },
        -- Same, but for OSX
        ["‘"] = { "<cmd>bnext<cr>", desc = "Show next buffer" },
        ["“"] = { "<cmd>bprev<cr>", desc = "Show previous buffer" },
        ["∑"] = { "<cmd>Bdelete<cr>", desc = "Delete buffer" },
        -- Same, but for OSX in a gui
        ["<D-]>"] = { "<cmd>bnext<cr>", desc = "Show next buffer" },
        ["<D-[>"] = { "<cmd>bprev<cr>", desc = "Show previous buffer" },
        ["<D-w>"] = { "<cmd>Bdelete<cr>", desc = "Delete buffer" },
        -- Schlepp-like
        ["<S-M-Down>"] = { "<cmd>m +<CR>", desc = "Move line 1 down" },
        ["<S-M-Up>"] = { "<cmd>m -2<CR>", desc = "Move line 1 up" },
        -- Additional Telescope bindings
        ["<Leader>fO"] = { "<cmd>Telescope vim_options<CR>", desc = "Search vim options" },
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
        ["<M-Left>"] = { "<C-Left>", desc = "Move left 1 word" },
        ["<M-Right>"] = { "<C-Right>", desc = "Move right 1 word" },
      },
      c = {
        -- Same, but for command mode
        ["<M-Backspace>"] = { "<C-w>", desc = "Delete word" },
        ["<M-Left>"] = { "<C-Left>", desc = "Move left 1 word" },
        ["<M-Right>"] = { "<C-Right>", desc = "Move right 1 word" },
      }
      -- }}}
    },
  },
}
