-- stylua: ignore start

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

vim.keymap.set("n", "gt", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "gT", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>o", function() Snacks.picker.files() end, { desc = "Open file picker" })
vim.keymap.set("n", "<leader>fw", function() Snacks.picker.grep() end, { desc = "Live grep" })

vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>i", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>y", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "<leader>n", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>N", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

vim.keymap.set("n", "<leader>x", function() Snacks.bufdelete() end, { desc = "Remove buffer" })

vim.keymap.set("n", "<leader>_", "<cmd>split<cr>", { desc = "Split horizontal" })

vim.keymap.set("n", "<leader>G", function() Snacks.lazygit() end, { desc = "LazyGit" })
-- stylua: ignore end
