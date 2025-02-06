vim.cmd('source ~/.config/nvim/legacy.vim')
vim.opt.signcolumn = 'yes'

require('config.lazy')

-- require('img-clip').setup ({
--   default = {
--     embed_image_as_base64 = false,
--     prompt_for_file_name = false,
--     drag_and_drop = { insert_mode = true, },
--   },
-- })
-- require('render-markdown').setup ({
--   file_types = { "markdown", "Avante" },
--   enable = true,
-- })
