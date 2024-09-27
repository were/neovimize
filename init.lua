vim.cmd('source ~/.config/nvim/legacy.vim')

-- deps:
require('img-clip').setup ({
  default = {
    embed_image_as_base64 = false,
    prompt_for_file_name = false,
    drag_and_drop = { insert_mode = true, },
  },

})
require('render-markdown').setup ({
  file_types = { "markdown", "Avante" },
  enable = true,
})
require('avante_lib').load()
require('avante').setup ({
  -- Your config here!
  provider = 'openai',
  openai = {
    model = 'gpt-4o-mini',
    timeout = 30000,
    max_tokens = 4096,
  }
})

