----
-- Options
----
vim.opt.showmode = false
vim.opt.endoffile = false
vim.opt.endofline = false

vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autoindent = true

vim.opt.autowrite = true
vim.opt.swapfile = false

vim.opt.wrap = true
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 30

vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.wildmenu = true
vim.opt.path:append("**")

vim.opt.signcolumn = "yes"
vim.g.netrw_banner = 0

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.lazyredraw = true

vim.opt.hlsearch = true

vim.opt.clipboard = "unnamedplus" -- please make this the default

vim.opt.list = true
vim.opt.ignorecase = true

----
-- Depedencies
----
-- autoinstall lazy
-- bootstrap every ~~zig~~ nvim!!11!!11
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require "config.lazy"
require("lazy").setup({
    -- file managing , picker etc
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    },

    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                globalstatus = true,
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff'},
                    lualine_c = {'filename', 'diagnostics'},
                    lualine_x = {"require'lsp-status'.status()", 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'},
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
            })
        end
    },

    {
        -- automagically close {} when typing (or similar stuff)
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter",
        config = true
    },

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000
	},

    {
        "terrortylor/nvim-comment",
        lazy = true,
        keys = {
            { " /", "<cmd>CommentToggle<cr>", mode = "n" },
            { " /", "<cmd><ESC>:CommentToggle<cr>", mode = "v" }
        },
        config = function()
            require("nvim_comment").setup({
                marker_padding = true,
                comment_empty = false,
                create_mappings = false,
            })
        end
    },

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")
			configs.setup({ 
				sync_install = false,
				highlight = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",  -- Start selection
						node_incremental = "<C-space>", -- Increment selection to the node
						node_decremental = "<BS>",       -- Decrement selection to previous node
					},
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufRead", "BufNewFile" },
        -- only start when insert mode
        -- this is because i sometimes browse files, but i dont want to start the diagnostics (because it will absolutely lag the shit out of my system)
        --  aaactually nvm this doesnt work. seems like it must fire when that happens.
		--[[ event = {"InsertEnter"}, ]]
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function ()
			local lsps = { "clangd", "gopls", "rust_analyzer" }
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local root = lspconfig.util.root_pattern(".git", "compile_flags.txt", "go.mod", "Gopkg.lock", ".")

			for _, s in pairs(lsps) do
				lspconfig[s].setup {
					root_dir = root,
					capabilities = capabilities,
				}
			end
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
        lazy = true,
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local snip = require("luasnip")
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local s = snip.snippet
			local t = snip.text_node
			local i = snip.insert_node

			snip.add_snippets("go", { 
				s("iferr", {
					t({"if err != nil {", "\t"}),
					i(1),
					t({"", "}"})
				}),
				s("reterr", {
					t("return "),
					i(1),
					t("err")
				})
			})

			cmp.setup({
				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif snip.expand_or_jumpable() then
							snip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif snip.jumpable(-1) then
							snip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				snippet = {
					expand = function(args)
						snip.lsp_expand(args.body)
					end
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
    },
    
    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        -- loads when keybind pressed; see lazy plugin start section
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                -- TODO: find nvchad's custom setup code and "borrow" it
            })
        end,
    },

    {
    	'nvim-telescope/telescope.nvim',
      	dependencies = { 'nvim-lua/plenary.nvim' },

        cmd = "Telescope",
        keys = {
            { " ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
            -- TODO: <leader>fw
            { " fw", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
            -- { "<C-v>", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
            -- { "<C-h>", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
            -- { "<C-s>", "<cmd>Telescope grep_string<cr>", desc = "Grep string under cursor" },
        },

        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                        },
                    },
                },
            })
        end
    },

    {
        "zbirenbaum/nvterm",
        version = "*",
        config = function ()
            require("nvterm").setup()
        end,
    },

    -- because you cant remember
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        cmd = "WhichKey",
        config = true,
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufRead", "BufNewFile" },
        config = function()
            require('gitsigns').setup()
        end
    },

    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = { "BufRead", "BufNewFile" },
        config = function()
            require'bufferline'.setup {
                options = {
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "files",
                            highlight = "Directory",
                            separator = true
                        }
                    }
                }
            }
        end
    },

    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require"dashboard".setup {
                hide = {
                    statusline = false,
                    tabline = false,
                    winbar = false,
                },
                config = {
                    header = {
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⢋⠹⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣩⣴⣿⣿⣿⣿⣿⣿⣿⣿]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣄⠼⠃⠀⠀⠀⠀⢀⣀⣀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢔⣛⣻⣭⣭⣭⣛⡛⠶⢿⣿⡻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣴⣾⣿⣿⣿⣿⣤⠶⠶⢮⣦⣀⠀⠉⠛⢽⡻⢿⣿⣿⣿⣿⣿⣿⣿]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢁⣴⣾⣿⣿⣿⣿⢿⣻⣭⣶⣶⣿⣿⣷⣾⣿⣿⣶⣄⡀⠙⢦⠹⣿⣿⣿⡿⣻⢽]],
[[⠀⠀⠀⠀⡀⠀⡀⠘⠁⣠⣾⣿⣿⣿⡿⣿⣷⣿⢟⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢶⣢⡀⠘⠛⠁⠜⢻⣾]],
[[⠀⢠⡶⢋⣤⣼⠛⠀⢔⣿⣿⣿⣿⢟⣿⣿⡿⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⢹⣿⡄⢀⡀⣀⣼⣿]],
[[⠀⠘⢡⣿⣿⡟⠀⢈⣾⢿⣿⡿⢣⣿⡟⠋⢼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⣿⣧⠀⣻⣟⠩⠾]],
[[⠀⠀⣼⡿⠿⠇⠀⣼⢏⣿⣿⠃⣼⣫⣾⡇⣾⣿⢟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⠀⠸⠟⠀⠒]],
[[⠀⠀⠈⠁⠀⡀⢸⡟⣸⡟⣟⡐⠛⠛⠿⢿⣿⡏⣼⣿⣿⣇⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⠇⣿⣿⠀⠀⢀⠀⠀]],
[[⠀⠀⠀⠀⡰⠁⣿⡇⣿⡇⣿⣿⣟⡁⠀⠀⠘⢀⣿⣿⡟⣼⣮⢿⣿⣿⡿⣿⣿⢳⣿⡿⢰⣿⣿⠀⣸⣿⣿⣆]],
[[⠀⠀⢠⡈⠀⠀⣿⠀⣿⡇⣿⣿⣿⣿⣶⣶⣾⣦⣿⣿⣷⣿⣏⢸⣿⡿⣿⣮⡋⣼⣿⠃⣾⣿⠉⠀⣿⣿⣿⣿]],
[[⠀⠀⢸⣿⢰⠀⣿⠀⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠟⢻⣿⡿⣰⡮⠁⣸⣿⣧⠀⣸⣿⣿⣿⣿]],
[[⠀⠀⠀⢻⠘⠀⠸⠀⢿⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⠀⠀⢀⠙⢵⣋⠄⣴⣿⢫⣤⡠⣻⣿⢿⣿⣿]],
[[⠀⠀⠀⠘⠀⠀⠀⠀⠘⠳⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣾⣧⡈⢏⣼⣿⡗⢺⢻⡇⢻⣷⣿⣿⠉]],
[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⠟⢉⣴⡿⡫⠊⠀⠀⠀⠀⠀⠛⠉⠋⠀]],
[[⠀⠃⠀⠀⠀⠀⠀⠀⠱⠤⠴⠀⠙⢿⣿⣿⣿⣿⣿⣿⠛⣛⡫⠽⢧⣴⡿⠋⠊⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⠀⠐⠛⠳⠀⠀⠀⠀⠀⠶⠴⠀⠀⠀⠉⠉⠉⠉⠉⠉⠉⠁⠀⣰⡿⠋⠀⣴⣶⣾⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⣀⡙⠛⠀⠀⢀⡄⠀⡐⠰⠧⠆⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠁⠀⢰⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
[[⣿⣿⣿⣶⣦⣀⣀⣘⠛⠿⠗⢀⣤⢤⠀⠀⠘⠛⠶⠆⠀⢀⡀⠀⠀⠀⠀⠉⠻⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
-- 55x21
                    },
                    shortcut = {
                        { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
                        {
                            icon = " ",
                            icon_hl = "@variable",
                            desc = "Files",
                            group = "Label",
                            action = "Telescope find_files",
                            key = "f",
                        },
                        {
                            icon = "󰩈 ",
                            desc = "help get me the fuck out of here",
                            action = "q",
                            key = "q",
                        }
                    },
                },
            }
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },

    {
        "filipdutescu/renamer.nvim",
        keys = {
            { "<F2>", "<cmd>lua require ('renamer').rename()<cr>" }
        },
        opts = {}
    }
}, lazy_config);

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = {}, -- Change the style of comments
        conditionals = {},
    },
    integrations = {
        nvimtree = true,
        treesitter = true,
        telescope = {
            enabled = true,
            -- style = "nvchad"
        },
        which_key = true,
    }
    -- TODO: integrations https://github.com/catppuccin/nvim#integrations
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
-- keybindings for telescope is at lazy.nvim telescope config
-- because declaring them here would load it

----
-- Keybinds
----
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function (ev)
		local opts = { buffer = ev.buf }
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>fs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
		vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
	end
})
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>dN", vim.diagnostic.goto_prev)

-- change ctrl+h/j/k/l so you dont have to ctrl+w h/j/k/l
-- because life's too short to expend more effort
vim.keymap.set('', '<C-h>', '<C-w>h')
vim.keymap.set('', '<C-j>', '<C-w>j')
vim.keymap.set('', '<C-k>', '<C-w>k')
vim.keymap.set('', '<C-l>', '<C-w>l')

-- ctrl+hjkl in insert mode move cursor
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-s>", ":w<CR>")

vim.keymap.set("n", ">", ">>")   -- < expects a group (like <ip), so I'm removing options here
vim.keymap.set("n", "<", "<<")   -- ^^ (can still be done a visual selection beforehand)
vim.keymap.set("v", "<", "<gv") 
vim.keymap.set("v", ">", ">gv") 

vim.keymap.set("n", "<Esc><Esc>", function()
    vim.cmd(":noh")
end, { desc = "clear highlights" })

-- lazy plugin start

vim.keymap.set('n', '<leader>h', function()
    require("nvterm.terminal").toggle("horizontal")
end, { desc = "toggle horizontal terminal" })

vim.keymap.set("n", "<TAB>", function()
    pcall(function()
        vim.cmd("BufferLineCycleNext")
    end)
end, { desc = "next tab" })
vim.keymap.set("n", "<S-TAB>", function()
    pcall(function()
        vim.cmd("BufferLineCyclePrev")
    end)
end, { desc = "prev tab" })
vim.keymap.set("n", "<leader>x", function()
    vim.cmd(":bdelete!")
end, { desc = "close buffer" })

-- aldsd;lsdfjdkldsldkslkdlsdkd;;ds;ds;sdfjkdlsdlkkld;fkds;jjfsdlkjlsjlkd

vim.api.nvim_create_autocmd({"BufFilePost"}, {
    group = augroup,
    pattern = "*.cpp,*.h",
    callback = function()
        vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
    end,
})
