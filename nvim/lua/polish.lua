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
  }
  vim.opt.guifont = table.concat(fonts, ',') .. ':' .. size

  if vim.g['neovide'] then
    if vim.fn.has('mac') then
      vim.g.neovide_input_use_logo = true
      vim.g.neovide_input_macos_alt_is_meta = "left_only"
    end
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_vfx_mode = "sonicboom"
  end
end

-- }}}

