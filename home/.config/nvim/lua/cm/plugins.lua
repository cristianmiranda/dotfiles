local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

-- Reloads Neovim after whenever you save plugins.lua
vim.cmd([[
    augroup packer_user_config
      autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]])

-- After updating any of this, run :PackerSync + :PackerCompile

packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Dashboard is a nice start screen for nvim
	use {
		'glepnir/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('dashboard').setup {
				theme = 'doom',
				config = {
					header = {
						"",
						"",
						"",
						"",
						"",
						"",
						" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
						" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
						" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
						" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
						" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
						" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
						"",
						"",
						"",
						"",

					}, --your header
					center = {
						{
							icon = '	',
							icon_hl = 'Title',
							desc = 'Recent sessions                         [SPC s l]',
							desc_hl = 'String',
							keymap = 'SPC s l',
							key_hl = 'Number',
							action = 'SessionLoad'
						},
						{
							icon = '	',
							icon_hl = 'Title',
							desc = 'Find recent files                       [SPC f r]',
							desc_hl = 'String',
							keymap = 'SPC f r',
							key_hl = 'Number',
                            action = 'Telescope oldfiles'
						},
						{
							icon = '	',
							icon_hl = 'Title',
							desc = 'Find files                              [SPC f f]',
							desc_hl = 'String',
							keymap = 'SPC f f',
							key_hl = 'Number',
							action = 'Telescope find_files find_command=rg,--hidden,--files'
						},
						{
							icon = '	',
							icon_hl = 'Title',
							desc = 'File browser                            [SPC f b]',
							desc_hl = 'String',
							keymap = 'SPC f b',
							key_hl = 'Number',
							action = 'Telescope file_browser'
						},
						{
							icon = '	',
							icon_hl = 'Title',
							desc = 'File word                               [SPC f w]',
							desc_hl = 'String',
							keymap = 'SPC f w',
							key_hl = 'Number',
							action = 'Telescope live_grep'
						},
						{
							icon = '	',
							icon_hl = 'Title',
							desc = 'Load new theme                          [SPC h t]',
							desc_hl = 'String',
							keymap = 'SPC h t',
							key_hl = 'Number',
							action = 'Telescope colorscheme'
						},
					},
					footer = {}
				},
			}
		end,
		requires = {'nvim-tree/nvim-web-devicons'}
	  }

	-- Tmux integration
    use({
        "aserowy/tmux.nvim",
        config = function() return require("tmux").setup() end
    })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-telescope/telescope-file-browser.nvim")

	use("nvim-treesitter/nvim-treesitter") -- Treesitter Syntax Highlighting

	-- Productivity
	use("vimwiki/vimwiki")
	use("jreybert/vimagit")
    use("voldikss/vim-floaterm")
	use("folke/which-key.nvim") -- Which Key
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

	-- File management --
	use("vifm/vifm.vim")
	use("scrooloose/nerdtree")
	use("tiagofumo/vim-nerdtree-syntax-highlight")
	use("ryanoasis/vim-devicons")

	-- Tim Pope Plugins --
	use("tpope/vim-surround")

	-- Syntax Highlighting and Colors --
	use("PotatoesMaster/i3-vim-syntax")
	use("kovetskiy/sxhkd-vim")
	use("vim-python/python-syntax")
	use("ap/vim-css-color")
	use("nickeb96/fish.vim")

	-- Junegunn Choi Plugins --
	use("junegunn/goyo.vim")
	use("junegunn/limelight.vim")
	use("junegunn/vim-emoji")

	-- Colorschemes --
	use("RRethy/nvim-base16")
	use("kyazdani42/nvim-palenight.lua")

	-- Other stuff --
	use("frazrepo/vim-rainbow")

	if packer_bootstrap then
		packer.sync()
	end
end)
