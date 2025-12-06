--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
--vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()
vim.api.nvim_set_keymap('n', '<C-e>', '<cmd>NvimTreeFindFileToggle<CR>', { noremap = true })

vim.keymap.set('n', '<leader>e', function()
  local view = require("nvim-tree.view")

  if view.is_visible() and vim.api.nvim_get_current_win() == view.get_winnr() then
    -- Eğer nvim-tree görünüyorsa ve odak oradaysa, önceki pencereye geç
    vim.cmd("wincmd p")
  else
    -- Aksi halde nvim-tree'ye focus yap
    vim.cmd("NvimTreeFocus")
  end
end, { noremap = true, silent = true, desc = "Toggle focus on NvimTree" })

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
