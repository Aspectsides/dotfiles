-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
local g = vim.g
local fn = vim.fn
local api = vim.api

g.rnvimr_enable_ex = 1
g.rnvimr_enable_picker = 1
g.rnvimr_edit_cmd = "drop"
g.rnvimr_draw_border = 0
g.rnvimr_hide_gitignore = 1
g.rnvimr_border_attr = { ["fg"] = 14, ["bg"] = -1 }
g.rnvimr_enable_bw = 1
g.rnvimr_shadow_winblend = 70

g.rnvimr_action = {
  ["<C-t>"] = "NvimEdit tabedit",
  ["<C-x>"] = "NvimEdit split",
  ["<C-v>"] = "NvimEdit vsplit",
  ["gw"] = "JumpNvimCwd",
  ["yw"] = "EmitRangerCwd",
}

g.rnvimr_presets = {
  { ["width"] = 0.800, ["height"] = 0.800 },
  { ["width"] = 0.600, ["height"] = 0.600 },
  { ["width"] = 0.950, ["height"] = 0.950 },
  { ["width"] = 0.500, ["height"] = 0.500, ["col"] = 0, ["row"] = 0 },
  { ["width"] = 0.500, ["height"] = 0.500, ["col"] = 0, ["row"] = 0.5 },
  { ["width"] = 0.500, ["height"] = 0.500, ["col"] = 0.5, ["row"] = 0 },
  { ["width"] = 0.500, ["height"] = 0.500, ["col"] = 0.5, ["row"] = 0.5 },
  { ["width"] = 0.500, ["height"] = 1.000, ["col"] = 0, ["row"] = 0 },
  { ["width"] = 0.500, ["height"] = 1.000, ["col"] = 0.5, ["row"] = 0 },
  { ["width"] = 1.000, ["height"] = 0.500, ["col"] = 0, ["row"] = 0 },
  { ["width"] = 1.000, ["height"] = 0.500, ["col"] = 0, ["row"] = 0.5 },
}

g.rnvimr_ranger_views = {
  {
    ["minwidth"] = 90,
    ["ratio"] = {},
  },
  {
    ["minwidth"] = 50,
    ["maxwidth"] = 89,
    ["ratio"] = { 1, 1 },
  },
  {
    ["maxwidth"] = 49,
    ["ratio"] = { 1 },
  },
}

g.rnvimr_layout = {
  ["relative"] = "editor",
  ["width"] = fn.float2nr(fn.round(0.7 * api.nvim_win_get_width(0))),
  ["height"] = fn.float2nr(fn.round(0.7 * api.nvim_win_get_height(0))),
  ["col"] = fn.float2nr(fn.round(0.15 * api.nvim_win_get_width(0))),
  ["row"] = fn.float2nr(fn.round(0.15 * api.nvim_win_get_height(0))),
  ["style"] = "minimal",
}

g.rnvimr_layout = {
  ["relative"] = "editor",
  ["width"] = api.nvim_win_get_width(0),
  ["height"] = api.nvim_win_get_height(0) - 2,
  ["col"] = 0,
  ["row"] = 0,
  ["style"] = "minimal",
}

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = { eob = " " }
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = false -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

vim.g.vimwiki_list = { { path = "~/Documents/vimwiki", syntax = "markdown", ext = ".md" } }

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
