return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    enabled = false,
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      symbols = {
        modified = "●",
        ellipsis = "…",
        separator = "",
      },
    },
  },
}
