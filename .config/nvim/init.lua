vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- rust
require'lspconfig'.rust_analyzer.setup{}
-- clang (c++)
require'lspconfig'.clangd.setup{}
require'lspconfig'.asm_lsp.setup{}

require("base46").toggle_transparency()
-- vim.opt.listchars = { trail = "·" }
vim.opt.list = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.api.nvim_win_set_option(0, 'colorcolumn', '110')
vim.cmd('highlight ColorColumn ctermbg=0 guibg=#0c0c0c')
vim.opt.showtabline = 0
vim.g.toggle_theme_icon = nil

vim.api.nvim_exec("aunmenu PopUp.How-to\\ disable\\ mouse", false)
vim.api.nvim_exec("aunmenu PopUp.-1-", false)
-- vim.api.nvim_exec("set mouse=", false) -- masochist mode: disables the mouse
vim.api.nvim_exec("set ttyfast", false)
vim.api.nvim_exec("set lazyredraw", false)
vim.api.nvim_exec("noswap", false)
vim.api.nvim_exec("set noswapfile", false)
vim.api.nvim_exec("set relativenumber", false)

