-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  { "tpope/vim-repeat",             lazy = false },
  { "tpope/vim-surround",           lazy = false },
  { "tpope/vim-unimpaired",         lazy = false },
  { "zirrostig/vim-schlepp",        lazy = false },
  -- Disable jj/jk escape keys
  { "max397574/better-escape.nvim", enabled = false },
}
