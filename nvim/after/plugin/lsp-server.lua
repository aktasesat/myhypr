vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    -- Keybindings, formatting vs buraya yazılabilir
  end
})

vim.lsp.start({
  name = 'pylsp',
  cmd = { 'pylsp' },
  root_dir = vim.fn.getcwd(), -- veya daha gelişmiş bir root finder
  settings = {
    pylsp = {
      plugins = {
        pyflakes = { enabled = true },
        pycodestyle = { enabled = true },
        pylsp_mypy = { enabled = false },
        pyls_black = { enabled = false },
      },
    },
  },
})
