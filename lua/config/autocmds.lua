pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7dcfff" })
  end,
})
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7dcfff" })
