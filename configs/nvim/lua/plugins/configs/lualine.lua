local M = {}
M.theme = function()
  local colors = {
    innerbg = nil,
  }
  return {
    inactive = {
      a = { bg = colors.innerbg },
      b = { bg = colors.innerbg },
      c = { bg = colors.innerbg },
      y = { bg = colors.innerbg },
      z = { bg = colors.innerbg, gui = "bold" },
    },
    visual = {
      a = { bg = colors.innerbg },
      b = { bg = colors.innerbg },
      c = { bg = colors.innerbg },
      y = { bg = colors.innerbg },
      z = { bg = colors.innerbg, gui = "bold" },
    },
    replace = {
      a = { bg = colors.innerbg },
      b = { bg = colors.innerbg },
      c = { bg = colors.innerbg },
      y = { bg = colors.innerbg },
      z = { bg = colors.innerbg, gui = "bold" },
    },
    normal = {
      a = { bg = colors.innerbg },
      b = { bg = colors.innerbg },
      c = { bg = colors.innerbg },
      y = { bg = colors.innerbg },
      z = { bg = colors.innerbg, gui = "bold" },
    },
    insert = {
      a = { bg = colors.innerbg },
      b = { bg = colors.innerbg },
      c = { bg = colors.innerbg },
      y = { bg = colors.innerbg },
      z = { bg = colors.innerbg, gui = "bold" },
    },
    command = {

      a = { bg = colors.innerbg },
      b = { bg = colors.innerbg },
      c = { bg = colors.innerbg },
      y = { bg = colors.innerbg },
      z = { bg = colors.innerbg, gui = "bold" },
    },
  }
end

return {
  {
    "nvim-lualine/lualine.nvim",
    version = false,
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")

      return {
        options = {
          icons_enabled = true,
          theme = M.theme(),
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
              padding = { left = 1, right = 1 },
            },
          },
          lualine_z = {
            { "filetype", icon_only = true, padding = { left = 1, right = 1 } },
            { "mode", padding = { left = 0, right = 1 } },
            { "branch", padding = { left = 0, right = 1 } },
            { "location", padding = { left = 0, right = 1 } },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
