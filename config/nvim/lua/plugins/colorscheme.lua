return {
  { -- Theme inspired by Atom
    "notken12/base46-colors",
    priority = 1000,
  },
  {
    "xero/sourcerer.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme sourcerer")
    end,
  },
  -- {
  --    "LazyVim/LazyVim",
  --    opts = {
  --      colorscheme = "nord",
  --    },
  --  },
}
