" {{{ --- Import vimrc ---

" Stolen from https://neovim.io/doc/user/nvim.html
set runtimepath^=$XDG_CONFIG_HOME/vim runtimepath+=$XDG_CONFIG_HOME/vim/after
let &packpath = &runtimepath
source $XDG_CONFIG_HOME/vim/vimrc

" }}}
" {{{ --- Import GUI settings if necessary

if has('gui') || (!has('ttyin') && !has('ttyout'))
    source $XDG_CONFIG_HOME/vim/gvimrc
endif

" }}}
" {{{ --- Autocompletion ---

" Automatically start COQ server
let g:coq_settings = {}
let g:coq_settings.auto_start = 'shut-up'
let g:coq_settings['display.preview.border'] = [["╭","NormalFloat"],["─","NormalFloat"],["╮","NormalFloat"],["│","NormalFloat"],["╯","NormalFloat"],["─","NormalFloat"],["╰","NormalFloat"],["│","NormalFloat"]]

" }}}
" {{{ --- Language Server Config ---

" Stolen from https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
lua <<END

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true, buffer=bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- Same as "goto tag", also populates jumplist
  vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
  -- Like IntellJ
  vim.keymap.set('n', '<C-j>', vim.lsp.buf.hover, opts)
  vim.keymap.set('i', '<C-j>', vim.lsp.buf.signature_help, opts)

  vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  vim.keymap.set('n', '<leader>re', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)

  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

end

-- Used in nvim/ftplugin/*.vim to load per-language LSP configs
-- We only load them in ftplugin so we can skip the ones we're not
-- using in the current session. This matters for some big ones like
-- jdtls.
function enable_lsp_config(server, settings)
    -- FIXME: Why do we need to call setup() twice?!
    require'lspconfig'[server].setup{}

    require'lspconfig'[server].setup(require'coq'.lsp_ensure_capabilities {
        on_attach = on_attach,
        settings = settings,
        })
end

END

" }}}

