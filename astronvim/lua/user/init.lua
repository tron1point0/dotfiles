local config = {
  options = {
    opt = {
      relativenumber = false, -- Reset to vim default
      foldmethod = "marker", -- Reset to vim default
      colorcolumn = "+0,+40", -- Highlight textwidth col and further out
      textwidth = 80, -- Default unless set by filetype
      tabstop = 4, -- Default unless set by filetype
      shiftwidth = 0, -- Use tabstop vaule unless set by filetype
      spell = true, -- Turn on spell checking
      winminwidth = 10, -- Don't allow windows to become too small
      list = true, -- Show nonprintable characters
      listchars = { -- Use these characters for that
        conceal = '⁞',
        extends = '❯',
        nbsp = '…',
        precedes = '❮',
        tab = '——⇥',
        trail = '•',
      },
    },
  },

  plugins = {
    init = {
      ["tpope/vim-repeat"] = {},
      ["tpope/vim-surround"] = {},
      ["tpope/vim-unimpaired"] = {},
      ["zirrostig/vim-schlepp"] = {},
      ["Konstruktionist/vim-fish"] = {},
      -- Disable jj/jk escape keys
      ["max397574/better-escape.nvim"] = { disable = true },
      ["mfussenegger/nvim-dap-python"] = {},
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
      -- Additional Telescope bindings
      ["<leader>so"] = { "<cmd>Telescope vim_options<CR>", desc = "Search vim options" },
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

  polish = function()
    -- Comments should be italic
    vim.cmd.highlight('Comment', 'gui=italic')

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
      local size = vim.fn.has('linux') > 0 and 'h12' or 'h14'
      local fonts = {
        'JetBrainsMono Nerd Font',
        'FiraCode Nerd Font',
        'Fira Code',
        'Liberation Mono',
        'Menlo',
      }
      vim.opt.guifont = table.concat(fonts, ',') .. ':' .. size

      if vim.g['neovide'] then
        if vim.fn.has('mac') then
          vim.g.neovide_input_use_logo = true
          vim.g.neovide_input_macos_alt_is_meta = true
        end
        vim.g.neovide_cursor_antialiasing = true
        vim.g.neovide_cursor_vfx_mode = "sonicboom"
      end
    end

    -- }}}
  end
}

return config
