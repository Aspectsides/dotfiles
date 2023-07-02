return {
  { -- Theme inspired by Atom
    "notken12/base46-colors",
    priority = 1000,
  },
  {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme miasma")
    end,
  },
  -- {
  --    "LazyVim/LazyVim",
  --    opts = {
  --      colorscheme = "nord",
  --    },
  --  },
}
