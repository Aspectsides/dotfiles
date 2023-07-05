-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep<cr>")
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>aa", "<cmd>TrackMark<cr>")
vim.keymap.set("n", "<leader>dd", "<cmd>TrackUnmark<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>Track<cr>")
vim.keymap.set("n", "<leader>ww", "<cmd>VimwikiIndex<cr>")
