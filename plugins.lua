return {
  'nvim-lua/plenary.nvim',
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  'nvim-telescope/telescope.nvim',
  'nvim-tree/nvim-web-devicons',
  'tpope/vim-fugitive',
  {
    'neoclide/coc.nvim',
    branch = 'release',
  },
  'github/copilot.vim',
  'stevearc/dressing.nvim',
  'MunifTanjim/nui.nvim',
  'HakonHarnes/img-clip.nvim',
  'MeanderingProgrammer/render-markdown.nvim',
}

-- Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': { -> avante#build('source=true') } }
