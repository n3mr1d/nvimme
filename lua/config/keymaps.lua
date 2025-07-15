-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Buat folder path dari file aktif
vim.keymap.set("n", "<leader>md", ":!mkdir -p %:h<CR>", { desc = "Make directory from current file" })
-- Add any additional keymaps here
