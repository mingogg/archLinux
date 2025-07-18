vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormatOnSave", {}),
  callback = function(event)
    vim.lsp.buf.format({ bufnr = event.buf, timeout_ms = 500 })
  end,
})

vim.api.nvim_create_user_command('W', 'w', {})
