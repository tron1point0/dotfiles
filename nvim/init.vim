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
let g:coq_settings['display.icons.mode'] = 'none'
let g:coq_settings['display.preview.border'] = ["","",""," ","","",""," "]

" }}}
" {{{ --- Language Server Config ---

" Stolen from https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
lua <<END
local lsp = require 'lspconfig'
local coq = require 'coq'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- Same as "goto tag", also populates jumplist
  buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- Like IntellJ
  buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('i', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  buf_set_keymap('n', '<leader>re', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
    'pylsp',                    -- pip3 install python-lsp-server[all]
    -- 'jedi_language_server',     -- pip3 install jedi-language-server
    'bashls',                   -- brew install bash-language-server
    'groovyls',                 -- ???
    'yamlls',                   -- brew install yaml-language-server
    'vimls',                    -- npm i -g vim-language-server
    'texlab',                   -- brew install texlab
    'sumneko_lua',              -- brew install lua-language-server
    -- 'perlpls',                  -- cpanm Perl::LanguageServer
    -- npm i -g code-langserver-extracted
    'cssls',
    'html',
    'jsonls',
    'eslint',
}
for _, server in ipairs(servers) do
  lsp[server].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

END

" }}}

