return {
  { "dharmx/track.nvim" },
  {
    "Manas140/Zazen.nvim",
    config = function()
      require("zazen").setup()
    end,
  },
}
